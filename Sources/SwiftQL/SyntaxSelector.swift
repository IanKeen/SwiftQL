import SwiftSyntax

public struct SyntaxSelector<T> {
    public let select: (Syntax) -> T?

    public init(select: @escaping (Syntax) -> T?) {
        self.select = select
    }

    public static func +<U: Syntax>(lhs: SyntaxSelector, rhs: SyntaxSelector<U>) -> SyntaxSelector<(T, U)> {
        return .init { syntax in
            guard
                let left = lhs.select(syntax),
                let right = rhs.select(syntax)
                else { return nil }

            return (left, right)
        }
    }
}

extension SyntaxSelector {
    public static var `class`: SyntaxSelector<ClassDeclSyntax> {
        return .init { $0.firstSearchingUp(of: ClassDeclSyntax.self) }
    }
    public static var string: SyntaxSelector<StringSegmentSyntax> {
        return .init { $0.firstSearchingDown(of: StringSegmentSyntax.self) }
    }
    public static var function: SyntaxSelector<FunctionDeclSyntax> {
        return .init { $0.firstSearchingDown(of: FunctionDeclSyntax.self) }
    }
}
