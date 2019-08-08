import SwiftSyntax

extension TokenKind {
    public var isIdentifier: Bool {
        switch self {
        case .identifier: return true
        default: return false
        }
    }
}
