## Related Work
{:#related-work}

In this section, we discuss the related work on the reproducibility of scientific experiments in scholarly articles,
ontologies for describing these experiments, and dependency injection as a design principle in experimental software.

### Scholarly publishing and reproducibility
Sarven will start this
{:.todo}

We should cite [LOD Lab](cite:cites LODLab),
as they brought a major new angle to reproducibility within the Semantic Web.
Should also look at their argumentation.
{:.todo}

### Ontologies and vocabularies for describing experiments
Sarven will start this
{:.todo}

### Dependency injection
{:#related-work-dependency-injection}

[Separation of concerns](cite:cites SeparationOfConcerns) is a software design principle in which software is
split up into separate components, each having their own separate task.
Fowler defines a [software component](cite:providesQuotationFor DependencyInjection) as
<q>a glob of software that's intended to be used, without change, by an application that is out of the control of the writers of the component</q>.
This design principle is especially useful for experimental software,
because it improves flexibility when for instance different implementations of an algorithm are be compared using different components.

One way of working with components is to call their functions yourself, which means that your define the flow of control.
Alternatively, with [Inversion of Control](cite:cites InversionOfControl,DesigningReusableClasses),
this flow can be defined by a software framework.
In the latter case, the functions of the framework don't have to be called by you, but the framework will call you for certain functionality when needed[^HollywoodPrinciple].

[^HollywoodPrinciple]: This concept is also know as the [Hollywood Principle](cite:cites HollywoodPrinciple): <q>Don't call us, we'll call you</q>

[Dependency Injection](cite:cites DependencyInjection) is a form of Inversion of Control where components
are injected into other components by an external component, i.e., an _Assembler_.
Experimental software is a category of software that benefits from this paradigm,
because it allows different components to be defined and injected independently
into this software to observe its experimental effects.

Three types of dependency injection are typically distinguished:

* Interface injection: The assembler calls an `inject` method in the target component to inject its dependencies.
* Setter injection: The assembler maps interfaces to implementation instances.
* Constructor injection: The assember maps interfaces to implementation classes with their constructor parameters and allows dynamic construction.

Each of these types require a configuration phase to wire the component instances or factories,
and an injection phase to plug in the actual dependencies inside components.
This wiring can either be done in code, or through external configuration files.
These configuration files are typically declarative, and can be defined in formats such as XML or JSON.
Separating configuration from code is considered a good practise in software design,
as it follows the principle of separating interfaces from implementation.