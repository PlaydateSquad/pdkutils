//
//  UIApplication.swift
//  PDKUtils
//
//  Created by Marquis Kurt on 13-11-2026.
//

import PlaydateKit

/// A Playdate game that registers an application using the PDUIKit flow.
public protocol UIApplication: PlaydateGame {
    /// The application's root view controller.
    var rootViewController: UIViewController { get set }
}

public extension UIApplication {
    func update() -> Bool {
        rootViewController.update()
        return true
    }
}

/// Instantiate the main application loop for a given UIApplication.
///
/// When writing your event handler for your Playdate project that uses PDUIKit, you can simplify the logic by using
/// this function:
/// ```swift
/// final class Game: UIApplication { ... }
///
/// nonisolated(unsafe) var game: Game!
/// @_cdecl("eventHandler") func eventHandler(
///     pointer: UnsafeMutablePointer<PlaydateAPI>,
///     event: System.Event,
///     arg _: CUnsignedInt
/// ) -> CInt {
///     game = UIApplicationMain(for: Game.self, with: pointer, listeningTo: event)
///     return 0
/// }
/// ```
/// - Parameter application: The type of application that will be executing the main flow.
/// - Parameter apiHandle: The pointer to the Playdate APIs.
/// - Parameter event: The system event listener.
public func UIApplicationMain<App: UIApplication>(
    for application: App.Type,
    with apiHandle: UnsafeMutablePointer<PlaydateAPI>,
    listeningTo event: System.Event
) -> App! {
    var app: App!
    switch event {
    case .initialize:
        Playdate.initialize(with: apiHandle)
        app = App()
        System.updateCallback = app.update
    default:
        app?.handle(event)
    }
    return app
}
