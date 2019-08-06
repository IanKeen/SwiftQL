import SwiftSyntax

public struct SyntaxMatcher {
    let matches: (Syntax) -> Bool

    public init(matches: @escaping (Syntax) -> Bool) {
        self.matches = matches
    }

    public static func ||(lhs: SyntaxMatcher, rhs: SyntaxMatcher) -> SyntaxMatcher {
        return .init { lhs.matches($0) || rhs.matches($0) }
    }
    public static func &&(lhs: SyntaxMatcher, rhs: SyntaxMatcher) -> SyntaxMatcher {
        return .init { lhs.matches($0) && rhs.matches($0) }
    }
}

extension SyntaxMatcher {
    public static var expressions: SyntaxMatcher {
        return .init(matches: { $0 is ExprListSyntax })
    }
    public static var classes: SyntaxMatcher {
        return .init(matches: { $0 is ClassDeclSyntax })
    }
    public static var functions: SyntaxMatcher {
        return .init(matches: { $0 is FunctionDeclSyntax })
    }
    public static var protocols: SyntaxMatcher {
        return .init(matches: { $0 is ProtocolDeclSyntax })
    }
    public static var structs: SyntaxMatcher {
        return .init(matches: { $0 is StructDeclSyntax })
    }
    public static var enums: SyntaxMatcher {
        return .init(matches: { $0 is EnumDeclSyntax })
    }
}
