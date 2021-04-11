public class DependencyContainer {

    public typealias Dependency = Any
    public typealias Resolver = () -> Dependency
    typealias Identifier = String

    private var dependencies: [Identifier: Resolver]

    public init() {
        dependencies = [:]
    }

    public func register<Dependency>(_ dependency: Dependency.Type, resolver: @escaping Resolver) {
        dependencies[resolverIdentifier(for: dependency)] = resolver
    }

    public func resolve<Dependency>(_ dependency: Dependency.Type) -> Dependency? {
        let resolver = dependencies[resolverIdentifier(for: dependency)]
        return resolver?() as? Dependency
    }

    private func resolverIdentifier<Dependency>(for dependency: Dependency.Type) -> Identifier {
        String(describing: dependency)
    }

}
