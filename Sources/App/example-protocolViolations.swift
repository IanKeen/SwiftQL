import SwiftQL
import SwiftSyntax

let codeProtocols = """
protocol Proto1 { }
protocol Proto2 { }
protocol Proto3 { }

class ObjectA: Proto1, Proto3 { }
class ObjectB: Proto3 { }
"""

func protocolViolations() {
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
}
