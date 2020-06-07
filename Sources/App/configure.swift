import Vapor
import Fluent
import FluentMongoDriver

extension Application {
    static let databaseUrl = URL(string: Environment.get("KEY")!)!
}

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    switch app.environment{
    case .development:
    try app.databases.use(.mongo(connectionString: "mongodb://127.0.0.1:27017/hello"), as: .mongo)
    case .production:
        try app.databases.use(.mongo(connectionString: "mongodb+srv://lord:lord7ouda@cluster0-geakv.mongodb.net/test"), as: .mongo)
    default:
        try app.databases.use(.mongo(connectionString: "mongodb://127.0.0.1:27017/hello"), as: .mongo)
    }

    // register routes
    try routes(app)
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))

    app.migrations.add(CreateGalaxy(), to: .mongo)

    // using a custom error handler
    app.middleware.use(ErrorMiddleware { req, error -> Response in
        // implement custom response...
        .init(status: .internalServerError, version: req.version, headers: .init(), body: .empty)
    })
}
