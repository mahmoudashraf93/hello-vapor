import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in

        return "Hello, world!"
    }

    app.get("galaxy") { req ->  EventLoopFuture<Galaxy> in

        let galaxy = Galaxy(name: "zebby")
        return galaxy.create(on: req.db)
            .map { galaxy }
    }

}
