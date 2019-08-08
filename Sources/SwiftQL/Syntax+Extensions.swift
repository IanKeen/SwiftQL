import SwiftSyntax

extension Syntax {
    public func firstSearchingUp<T: Syntax>(of: T.Type, where predicate: (T) -> Bool = { _ in true }) -> T? {
        if let result = self as? T, predicate(result) { return result }
        return parent?.firstSearchingUp(of: T.self, where: predicate)
    }
    public func firstSearchingDown<T: Syntax>(of: T.Type, where predicate: (T) -> Bool = { _ in true }) -> T? {
        if let result = self as? T, predicate(result) { return result }
        return children.compactMap({ $0.firstSearchingDown(of: T.self, where: predicate) }).first
    }
}

extension Syntax {
    public func children<T: Syntax>(of: T.Type) -> [T] {
        return children.compactMap { $0 as? T }
    }

    public func allChildren() -> [Syntax] {
        var result: [Syntax] = []
        for child in children {
            result.append(child)
            result.append(contentsOf: child.allChildren())
        }
        return result
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
