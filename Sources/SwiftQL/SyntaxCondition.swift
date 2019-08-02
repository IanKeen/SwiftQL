import SwiftSyntax

public struct SyntaxCondition {
    public let predicate: (Syntax) -> Bool

    public init(predicate: @escaping (Syntax) -> Bool) {
        self.predicate = predicate
    }

    public static func &&(lhs: SyntaxCondition, rhs: SyntaxCondition) -> SyntaxCondition {
        return .init { lhs.predicate($0) && rhs.predicate($0) }
    }
    public static func ||(lhs: SyntaxCondition, rhs: SyntaxCondition) -> SyntaxCondition {
        return .init { lhs.predicate($0) || rhs.predicate($0) }
    }
}

extension SyntaxCondition {
    public static var all: SyntaxCondition { return .init { _ in true } }
}


extension SyntaxCondition {
    public static var `private`: SyntaxCondition {
        return .init { node in
            let list = node.children(of: ModifierListSyntax.self).first
            let modifiers = list?.children(of: DeclModifierSyntax.self) ?? []
            return modifiers.contains(where: { $0.name.tokenKind == .privateKeyword })
        }
    }
    public static var `internal`: SyntaxCondition {
        return .init { node in
            let list = node.children(of: ModifierListSyntax.self).first
            let modifiers = list?.children(of: DeclModifierSyntax.self) ?? []
            var override = false
            for modifier in modifiers {
                if modifier.name.tokenKind == .internalKeyword {
                    return true
                } else if modifier.name.tokenKind == .identifier("override") {
                    override = true
                }
            }
            return modifiers.isEmpty || (modifiers.count == 1 && override)
        }
    }
    public static var `public`: SyntaxCondition {
        return .init { node in
            let list = node.children(of: ModifierListSyntax.self).first
            let modifiers = list?.children(of: DeclModifierSyntax.self) ?? []
            return modifiers.contains(where: { $0.name.tokenKind == .publicKeyword })
        }
    }
    public static var `override`: SyntaxCondition {
        return .init { node in
            let list = node.children(of: ModifierListSyntax.self).first
            let modifiers = list?.children(of: DeclModifierSyntax.self) ?? []
            return modifiers.contains(where: { $0.name.tokenKind == .identifier("override") })
        }
    }
}

extension SyntaxCondition {
    public static var instance: SyntaxCondition {
        return .init { node in
            guard let parent = node.parent else { return false }
            return parent is MemberDeclListItemSyntax
        }
    }
}
