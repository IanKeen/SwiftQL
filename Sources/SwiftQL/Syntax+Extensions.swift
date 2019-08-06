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
}

extension Syntax {
    public func children<T: Syntax>(of: T.Type) -> [T] {
        return children.compactMap { $0 as? T }
    }
    public func allChildren<T: Syntax>(of: T.Type) -> [T] {
        var result: [T] = []
        for child in children {
            if let match = child as? T {
                result.append(match)
            }
            result.append(contentsOf: child.allChildren(of: T.self))
        }
        return result
    }
}
