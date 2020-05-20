---
layout: post
author: Jan Timar
title:  "Coordinator+UINavigationController+SwiftUI=❤️"
date:   2020-05-21 7:30:00 +0100
---

When your SwiftUI app more then one screen you probably start fighting with some NavigationView issues. Few of them can be resolved with old good UINavigationController. With this article, I will show you how you can use UINavigationController inside Coordinator with SwiftUI screens.

With my app I must resolve this issues:
- Hidden NavigationLink to resolve missing environment when using UIKit component
- Challenging with a hide navigation bar
- UISerachController in SwitUI doesn't exist
- Transparent navigation bar when trying large title on the second screen
- One screen know about other screen representation
- Immediately create next struct next View when creating NavigationLink

... 

And I think there are a little bit more problems with the current NavigationView.

### Let's start with Coordinator

I miss Coordinator more and more when my app is growing, so I decide to kill two birds with one stone and add UINavigatinNController with Coordinator.

```swift
final class Coordinator {

    let navigationController: UINavigationController

    convenience init<T: View>(
        rootView: T,
        container: InjectionContainer = InjectionContainerKey.defaultValue,
        appStyle: AppStyleProtocol = AppStyleKey.defaultValue
    ) {
        self.init(container: container, appStyle: appStyle)
        self.update(rootView: rootView, animated: false)
    }

    init(
        container: InjectionContainer = InjectionContainerKey.defaultValue,
        appStyle: AppStyleProtocol = AppStyleKey.defaultValue
    ) {
        self.container = container
        self.appStyle = appStyle
        self.navigationController = .init()
    }

    // MARK: - Combine
    private var disposables = Set<AnyCancellable>()

    // MARK: - Environment properties
    private var container: InjectionContainer
    private var appStyle: AppStyleProtocol
}
```

Implement it like class is required only for `disposables` property, without Combine integration, you can implement it like a struct. One of my challenges, when I change it to UINavigationController, was missing environment properties on the next screens, so I decide it store `InjectionContainer` and `AppStyleProtocol` inside Coordinator. With a small extension, I can transform any View to UIHostingController and add all required environments.

```swift
private extension Coordinator {

    /// Transform SwiftUI View to UIKit UIView and add known environment properties
    /// - Parameter view: SwiftUI View
    func transform<T: View>(view: T) -> UIHostingController<AnyView> {
        UIHostingController(
            rootView: AnyView(
                view
                    .environment(\.injected, container)
                    .environment(\.style, appStyle)
            )
        )
    }
}
```

### Hide any evidence about UINavigationController

With the second extension I enable push, pop, present, and update any swift View and hide UIKit dependency.

```swift
private extension Coordinator {
    func push<T: View>(view: T, animated: Bool = true) {
        navigationController
            .pushViewController(
                transform(view: view),
                animated: animated
            )
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func present<T: View>(
        view: T, animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        navigationController
            .topViewController?
            .present(
                transform(view: view),
                animated: animated,
                completion: completion
        )
    }

    func update<T: View>(rootView: T, animated: Bool = true) {
        navigationController.setViewControllers(
            [transform(view: rootView)],
            animated: animated
        )
    }
}
```
### Example with push ExampleScreen

In my case is this extension private because I decide to extend Coordinator with `*ViewModelPresenting` protocol, but when you working with [ReSwift][1] your Coordinator can handle some action and then open a new screen or you can use closures or call it directly, it's only in your hands.

In my way, I add ExampleScreen and one more extension to show red and green screens to test Coordinator implementation.

```swift
struct ExampleScreen: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(color)
    }
}

extension Coordinator {
    func showRedScreen() {
        let redScreen = ExampleScreen(
            title: "red",
            color: .red,
            action: { self.pop() }
        )
        push(view: redScreen)
    }

    func showGreenScreen() {
        let greenScreen = ExampleScreen(
            title: "green",
            color: .green,
            action: showRedScreen
        )
        update(rootView: greenScreen)
    }
}
```

### Initialize your coordinator

To implement Coordinator in your app you should initialize it in your SceneDelegate.

```swift
func scene(
	_ scene: UIScene,
	willConnectTo session: UISceneSession,
	options connectionOptions: UIScene.ConnectionOptions
) {
	guard let windowScene = scene as? UIWindowScene else { return }

    let coordinator = Coordinator(
        container: InjectionContainerKey.defaultValue,
        appStyle: AppStyleKey.defaultValue
    )
    coordinator.showGreenScreen()
    self.coordinator = coordinator

    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = coordinator.navigationController
	self.window = window
	window.makeKeyAndVisible()
}
```

{:refdef: style="text-align: center;"}
![Coordinator](/assets/Coordinator/coordinator.mov){:height="734px" width="357px"}
{: refdef}

### In the end

To sum up, `NavigationView` will be great one day, but IMHO I don't think this day is today or tomorrow. Until this day, we still can join the best from SwiftUI with UIKit and using UINavigationController with SwiftUI Views. Like the icing on the cake we can bring Coordinator to our architecture and separate layers from each other.

[1]:https://github.com/ReSwift/ReSwift