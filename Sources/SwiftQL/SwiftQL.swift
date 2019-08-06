import SwiftSyntax
import Foundation

public class SwiftQL {
    private class Visitor: SyntaxVisitor {
        typealias NodeProcessor = (Syntax) -> Void

        var processors: [NodeProcessor] = []
        
        override func visitPre(_ node: Syntax) {
            processors.forEach { $0(node) }
        }
    }

    private let sourceFile: SourceFileSyntax

    public init(code: String) throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: false).appendingPathExtension("swift")
        try Data(code.utf8).write(to: url)
        print("WRITING TO: ", url.absoluteString)
        self.sourceFile = try SyntaxTreeParser.parse(url)
    }
}

extension SwiftQL {
    public func execute<A>(_ a: SyntaxQuery<A>) -> [A] {
        let visitor = Visitor()
        visitor.processors.append(a.process)
        sourceFile.walk(visitor)
        return a.matches.compactMap(a.selector.select)
    }
    public func execute<A, B>(_ a: SyntaxQuery<A>, _ b: SyntaxQuery<B>) -> ([A], [B]) {
        let visitor = Visitor()
        visitor.processors.append(contentsOf: [
            a.process, b.process
        ])
        sourceFile.walk(visitor)
        return (
            a.matches.compactMap(a.selector.select),
            b.matches.compactMap(b.selector.select)
        )
    }
}
