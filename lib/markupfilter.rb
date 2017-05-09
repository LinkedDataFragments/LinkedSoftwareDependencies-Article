class MarkupFilter < Nanoc::Filter
  identifier :markupfilter

  def run(content, params = {})
    content = content.dup

    include_code_blocks content

    labels = create_labels content
    add_labels_to_figures content, labels
    set_reference_labels content, labels

    move_references_to_main content
    move_heading_ids_to_section content

    content
  end

  # Moves the references section into <main>
  def move_references_to_main content
    references = content[%r{<h2 id="references">.*?</dl>}m]
    content[references] = ''
    content['</main>'] = "<section>\n" + references + "\n</section>\n</main>"
  end

  # Moves IDs on headings to their parent section
  def move_heading_ids_to_section content
    content.gsub! /<section>(\s*)(<h\d[^>]*)(\sid=[^\s>]+)/,
                  '<section\3>\1\2'
  end

  # Includes code blocks from external files
  def include_code_blocks content
    content.gsub! %r{````(/[^`]+)````} do
      code = @items[$1]
      raise "Code block #{$1} not found." unless code
      "<pre><code>#{h code.raw_content}</code></pre>"
    end
  end

  # Creates labels for referenceable elements
  def create_labels content
    reference_counts = {}
    labels = content.scan(/<(\w+)([^>]*\s+id="([^"]+)"[^>]*)>/)
                    .map do |tag, attribute_list, id|
      type = label_type_for tag.downcase.to_sym, attribute_list
      number = (reference_counts[type] || 0) + 1
      reference_counts[type] = number
      [id, "#{type} #{number}"]
    end
    labels.to_h
  end

  # Determines the label type of a given element
  def label_type_for tag, attribute_list
    case tag
    when :h2
      'Section'
    when :figure
      case parse_attributes(attribute_list)[:class]
      when 'listing'
        'Listing'
      else
        'Fig.'
      end
    else
      'Unknown'
    end
  end

  # Adds labels to referenceable figures
  def add_labels_to_figures content, labels
    content.gsub! %r{<figure[^>]*\s+id="([^"]+)".*?<figcaption>(?:\s*<p>)?}m do |match|
      if labels.key? $1
        %{#{match}<span class="label">#{h labels[$1]}:</span> }
      else
        match
      end
    end
  end

  # Sets the labels of unlabeled references in the text
  def set_reference_labels content, labels
    content.gsub! %r{(<a href="#([^"]+)">)(</a>)} do |match|
      if labels.key? $2
        "#{$1}#{h labels[$2]}#{$3}"
      else
        match
      end
    end
  end

  # Parses a string of HTML attributes
  def parse_attributes attribute_list
    attribute_list.scan(/\s*(\w+)\s*=\s*"([^"]+)"\s*/)
                  .map { |k,v| [k.downcase.to_sym, v] }
                  .to_h
  end
end