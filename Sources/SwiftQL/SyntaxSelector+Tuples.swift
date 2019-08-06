import SwiftSyntax

public func +<A: Syntax, B: Syntax, C: Syntax>(lhs: SyntaxSelector<(A, B)>, rhs: SyntaxSelector<C>) -> SyntaxSelector<(A, B, C)> {
    return .init { syntax in
        guard let left = lhs.select(syntax), let right = rhs.select(syntax) else { return nil }
        return (left.0, left.1, right)
    }
}
public func +<A: Syntax, B: Syntax, C: Syntax, D: Syntax>(lhs: SyntaxSelector<(A, B, C)>, rhs: SyntaxSelector<D>) -> SyntaxSelector<(A, B, C, D)> {
    return .init { syntax in
        guard let left = lhs.select(syntax), let right = rhs.select(syntax) else { return nil }
        return (left.0, left.1, left.2, right)
    }
}
public func +<A: Syntax, B: Syntax, C: Syntax, D: Syntax, E: Syntax>(lhs: SyntaxSelector<(A, B, C, D)>, rhs: SyntaxSelector<E>) -> SyntaxSelector<(A, B, C, D, E)> {
    return .init { syntax in
        guard let left = lhs.select(syntax), let right = rhs.select(syntax) else { return nil }
        return (left.0, left.1, left.2, left.3, right)
    }
}
public func +<A: Syntax, B: Syntax, C: Syntax, D: Syntax, E: Syntax, F: Syntax>(lhs: SyntaxSelector<(A, B, C, D, E)>, rhs: SyntaxSelector<F>) -> SyntaxSelector<(A, B, C, D, E, F)> {
    return .init { syntax in
        guard let left = lhs.select(syntax), let right = rhs.select(syntax) else { return nil }
        return (left.0, left.1, left.2, left.3, left.4, right)
    }
}
public func +<A: Syntax, B: Syntax, C: Syntax, D: Syntax, E: Syntax, F: Syntax, G: Syntax>(lhs: SyntaxSelector<(A, B, C, D, E, F)>, rhs: SyntaxSelector<G>) -> SyntaxSelector<(A, B, C, D, E, F, G)> {
    return .init { syntax in
        guard let left = lhs.select(syntax), let right = rhs.select(syntax) else { return nil }
        return (left.0, left.1, left.2, left.3, left.4, left.5, right)
    }
}
