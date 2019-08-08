import SwiftQL
import SwiftSyntax

let codeA11y = """
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

func a11y() {
    print("Extract accessibility identifiers")
    let a11yQuery = SyntaxQuery(find: .expressions, where: .a11yId, selecting: .class + .string)
    let a11y = try! SwiftQL(code: codeA11y).execute(a11yQuery)
    print(a11y.map({ ($0.identifier.text, $1.content.text) }))
    print("\n")
}
