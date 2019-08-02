import SwiftSyntax

extension Syntax {
    public func firstSearchingUp<T: Syntax>(of: T.Type) -> T? {
        if let result = self as? T { return result }
        return parent?.firstSearchingUp(of: T.self)
    }
    public func firstSearchingDown<T: Syntax>(of: T.Type) -> T? {
        if let result = self as? T { return result }
        return children.compactMap({ $0.firstSearchingDown(of: T.self) }).first
    }

    public func children<T: Syntax>(of: T.Type) -> [T] {
        return children.compactMap { $0 as? T }
    }
}
