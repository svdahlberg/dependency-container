# DependencyContainer

A lightweight IOC container for resolving dependencies. 

## Usage

You use `DependencyContainer` by first registering a dependency, by providing its type and a closure that returns an instance of it. Since you need to register your dependencies before resolving them you should do it as early as possible, in `AppDelegate`, `application:didFinishLaunchingWithOptions:`. 

```
let container = DependencyContainer()

container.register(IService.self, resolver: { Service() })
```

When you call resolve you will get the instance of the service, like this:

```
let service = container.resolve(IService.self) // returns an instance of `Service`
```

A use case for the dependency container is if you easily want to provide a mocked implementation of a service. In the following example a mock version of the service is registered if the app is compiled with a `MOCK` flag enabled.

```
#if MOCK
container.register(IService.self, resolver: { MockService() })
#else
container.register(IService.self, resolver: { Service() })
#endif
```

Type definitions:

```
protocol IService {
    func doWork()
}

struct Service {
    func doWork() {
        print("Working")
    }
}

struct MockService {
    func doWork() {
        print("Pretending to work")
    } 
}
```
