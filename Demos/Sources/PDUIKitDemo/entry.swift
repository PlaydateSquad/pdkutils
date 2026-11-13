import PlaydateKit
import PDUIKit

nonisolated(unsafe) var game: Game!
@_cdecl("eventHandler") func eventHandler(
    pointer: UnsafeMutablePointer<PlaydateAPI>,
    event: System.Event,
    arg _: CUnsignedInt
) -> CInt {
    game = UIApplicationMain(for: Game.self, with: pointer, listeningTo: event)
    return 0
}
