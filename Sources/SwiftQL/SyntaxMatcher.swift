import SwiftSyntax

public struct SyntaxMatcher {
    public let matches: (Syntax) -> Bool

    public init(matches: @escaping (Syntax) -> Bool) {
        self.matches = matches
    }

    public static func ||(lhs: SyntaxMatcher, rhs: SyntaxMatcher) -> SyntaxMatcher {
        return .init { lhs.matches($0) || rhs.matches($0) }
    }
}


extension SyntaxMatcher {
    public static var expressions: SyntaxMatcher {
        return .init(matches: { $0 is ExprListSyntax })
    }
}
