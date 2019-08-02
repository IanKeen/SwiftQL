import SwiftQL
import SwiftSyntax

let code = """
class Foo {
    let tableView = UITableView()
    let other = UIViewController()
    func bar() {
        tableView.accessibilityIdentifier = "table_view_id"
        other.title = "hi"
    }
}
"""

extension SyntaxCondition {
    static var a11yId: SyntaxCondition {
        return .init { node in
            guard let member = node.child(at: 0) as? MemberAccessExprSyntax else { return false }
            return member.name.text == "accessibilityIdentifier"
        }
    }
}

// Extract accessibility identifiers


let swiftQL = try! SwiftQL(code: code)

swiftQL.query(find: .expressions, where: .a11yId, selecting: .class + .string) { result in
    print(result.map({ ($0.identifier.text, $1.content.text) }))
}
