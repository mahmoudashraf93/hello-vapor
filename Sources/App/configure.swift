import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))

    // using a custom error handler
    app.middleware.use(ErrorMiddleware { req, error -> Response in
        // implement custom response...
        .init(status: .internalServerError, version: req.version, headers: .init(), body: .empty)
    })
}
