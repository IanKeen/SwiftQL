import SwiftSyntax
import Foundation

public class SwiftQL {
    private class Visitor: SyntaxVisitor {
        var matches: [Syntax] = []
        let matcher: SyntaxMatcher

        init(matcher: SyntaxMatcher) {
            self.matcher = matcher
        }

        override func visitPre(_ node: Syntax) {
            guard matcher.matches(node) else { return }
            matches.append(node)
        }
    }

    private let sourceFile: SourceFileSyntax

    public init(code: String) throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: false).appendingPathExtension("swift")
        try Data(code.utf8).write(to: url)
        print("WRITING TO: ", url.absoluteString)
        self.sourceFile = try SyntaxTreeParser.parse(url)
    }

    public func query<T>(find matcher: SyntaxMatcher, where condition: SyntaxCondition = .all, selecting selector: SyntaxSelector<T>, complete: ([T]) -> Void) {
        let completeMatcher = SyntaxMatcher { matcher.matches($0) && condition.predicate($0) }
        let visitor = Visitor(matcher: completeMatcher)
        sourceFile.walk(visitor)
        complete(visitor.matches.compactMap(selector.select))
    }
}
