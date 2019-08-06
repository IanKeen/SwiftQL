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

print("Extract accessibility identifiers")
let a11yQuery = SyntaxQuery(find: .expressions, where: .a11yId, selecting: .class + .string)
let a11y = try! SwiftQL(code: codeA11y).execute(a11yQuery)
print(a11y.map({ ($0.identifier.text, $1.content.text) }))
print("\n")



let codeProtocols = """
protocol Proto1 { }
protocol Proto2 { }
protocol Proto3 { }

class ObjectA: Proto1, Proto3 { }
class ObjectB: Proto3 { }
"""

print("Protocol Abnormalitites")
let allInheritance = SyntaxQuery(find: .classes || .structs || .enums, selecting: .inheritance)
let allProtocols = SyntaxQuery(find: .protocols, selecting: .protocol)

let (inheritance, protocols) = try! SwiftQL(code: codeProtocols).execute(allInheritance, allProtocols)

let inheritedTypes = inheritance.flatMap { $0.allChildren(of: SimpleTypeIdentifierSyntax.self) }
let counts = protocols.reduce(into: [ProtocolDeclSyntax: Int]()) { result, proto in
    result[proto] = inheritedTypes.filter({ $0.name.text == proto.identifier.text }).count
}

for (proto, count) in counts {
    if count == 0 {
        print("UNUSED PROTOCOL:", proto.identifier.text)
    } else if count == 1 {
        print("UNNEEDED PROTOCOL:", proto.identifier.text)
    }
}
