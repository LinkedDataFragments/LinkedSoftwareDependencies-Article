## Abstract
<!-- Context      -->
In Empirical Software Engineering,
replications provide knowledge on what results hold under which conditions.
Often, these ought to be exact: the experimental procedures and their accompanying software are matched as closely as possible.
<!-- Need         -->
Because different algorithms, or implementations thereof, need to be easily swappable in a transparent manner,
a Dependency Injection (DI) design benefits experimental software.
Various wiring of independent components can be created, tested, and compared---even through means of static program analysis.
Within the Semantic Web,
the opportunity exists to move beyond the local scope of existing DI frameworks and 
facilitate exact replication on the Web with addressable, dereferenceable, and unambiguous software configurations.
<!-- Task         -->
Therefore, 
we introduce Components.js, a Semantic Dependency Injection framework for JavaScript,
that (i) describes software components using a _Object-Oriented Components_ and _Object Mapping_ ontology, 
(ii) automatically instantiates experimental configurations using linking and dereferencing, and
(iii) is complementary to the _modular programming_ of package managers.
<!-- Object       -->
This article presents the framework, 
its application, 
and incorporates a proof-of-concept on discovery of experimental software configurations on the Web.
<!-- Findings     -->
All 600,000+ Node Package Manager libraries were described
as more than 300 million RDF triples, which interlink different modules.
Thereby, a set of queries provide insights like what experiments use the same algorithm, 
or the different implementations of the same function.
<!-- Conclusion   -->
Components.js enables research articles to complete the provenance chain of experimental results.
This ultimately brings faster and more accurate reproductions of experiments,
and facilitates the evaluation of new research contributions.
