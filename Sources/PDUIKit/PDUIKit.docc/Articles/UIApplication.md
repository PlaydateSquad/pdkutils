# ``PDUIKit/UIApplication``

## Overview

With a `UIApplication`, you can automatically adopt the Playdate's game
lifecycle using your existing views and view controllers. `UIApplication`
extends the `PlaydateGame` protocol used to handle the game lifecycle,
hooking into your view controllers to automatically manage stages.

Start by creating a final class that conforms to `UIApplication`:

```swift
import PDUIKit

class ViewController: UIViewController { ... }

final class MyApplication: UIApplication {
    var rootViewController: UIViewController
    
    init() {
        let viewController = ViewController()
        let navigationController = UINavigationController(
          rootViewController: viewController)
        self.rootViewController = navigationController
    }
}
```

The ``UIViewController/update()`` function for your application's root
view controller automatically is invoked when this application updates.

`UIApplication` types can be registered and used in your game's event
handler to manage updates; if you don't require a custom implementation,
you can use the ``UIApplicationMain(for:with:listeningTo:)`` function to
automatically create and register your application:

```swift
import PlaydateKit
import PDUIKit

nonisolated(unsafe) var mainApplication: MyApplication!

@_cdecl("eventHandler") func eventHandler(
    pointer: UnsafeMutablePointer<PlaydateAPI>,
    event: System.Event,
    arg _: CUnsignedInt
) -> CInt {
    mainApplication = UIApplicationMain(
        for: MyApplication.self,
        with: pointer,
        listeningTo: event)
    return 0
}
```

## Topics

### Register an application

- ``UIApplicationMain(for:with:listeningTo:)``
