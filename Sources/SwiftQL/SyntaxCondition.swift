import SwiftSyntax

public struct SyntaxCondition {
    public let predicate: (Syntax) -> Bool

    public init(predicate: @escaping (Syntax) -> Bool) {
        self.predicate = predicate
    }
}

extension SyntaxCondition {
    static public var all: SyntaxCondition { return .init { _ in true } }
}
