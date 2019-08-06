import SwiftSyntax

public class SyntaxQuery<T> {
    let matcher: SyntaxMatcher
    let condition: SyntaxCondition
    let selector: SyntaxSelector<T>
    private(set) var matches: [Syntax] = []

    public init(find matcher: SyntaxMatcher, where condition: SyntaxCondition = .all, selecting selector: SyntaxSelector<T>) {
        self.matcher = matcher
        self.condition = condition
        self.selector = selector
    }

    func process(node: Syntax) {
        guard matcher.matches(node) && condition.predicate(node) else { return }
        matches.append(node)
    }
}
