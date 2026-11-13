import PlaydateKit

/// A structure that represents a size.
public struct UISize: Equatable {
    /// The size's width.
    public var width: Float

    /// The size's height.
    public var height: Float
    
    public init(width: Float, height: Float) {
        self.width = width
        self.height = height
    } 
}

public extension UISize {
    /// A size of zero.
    static var zero: UISize { UISize(width: 0, height: 0) }

    /// The size of the Playdate's display.
    static var display: UISize {
        UISize(width: Float(Display.width), height: Float(Display.height))
    }

    /// Whether the the point fits within the specified size.
    func contains(_ point: Point) -> Bool {
        let (xRange, yRange) = (0..<Int(width), 0..<Int(height))
        return xRange.contains(Int(point.x)) && yRange.contains(Int(point.y))
    }
}
