import SwiftSyntax

extension Syntax {
    public func firstSearchingUp<T: Syntax>(of: T.Type) -> T? {
        if let result = self as? T { return result }
        return children.compactMap({ $0.firstSearchingUp(of: T.self) }).first
    }
    public func firstSearchingDown<T: Syntax>(of: T.Type) -> T? {
        if let result = self as? T { return result }
        return parent?.firstSearchingDown(of: T.self)
    }
}
