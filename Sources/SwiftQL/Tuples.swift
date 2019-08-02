public func args<A, B, C>(_ args: ((A, B), C)) -> (A, B, C) {
    return (args.0.0, args.0.1, args.1)
}
public func args<A, B, C, D>(_ args: (((A, B), C), D)) -> (A, B, C, D) {
    return (args.0.0.0, args.0.0.1, args.0.1, args.1)
}
public func args<A, B, C, D, E>(_ args: ((((A, B), C), D), E)) -> (A, B, C, D, E) {
    return (args.0.0.0.0, args.0.0.0.1, args.0.0.1, args.0.1, args.1)
}
public func args<A, B, C, D, E, F>(_ args: (((((A, B), C), D), E), F)) -> (A, B, C, D, E, F) {
    return (args.0.0.0.0.0, args.0.0.0.0.1, args.0.0.0.1, args.0.0.1, args.0.1, args.1)
}
public func args<A, B, C, D, E, F, G>(_ args: ((((((A, B), C), D), E), F), G)) -> (A, B, C, D, E, F, G) {
    return (args.0.0.0.0.0.0, args.0.0.0.0.0.1, args.0.0.0.0.1, args.0.0.0.1, args.0.0.1, args.0.1, args.1)
}
