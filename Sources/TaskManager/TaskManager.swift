// The Swift Programming Language
// https://docs.swift.org/swift-book
import ArgumentParser
import Foundation
import SQLite

struct TaskExpressions {
    let id = Expression<Int64>("id")
    let title = Expression<String>("title")
    let isCompleted = Expression<Bool>("is_completed")
    let createdAt = Expression<Date>("created_at")
}

@main
struct TaskManager: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A simple command-line task manager.",
        subcommands: [Add.self, List.self, Complete.self]
    )

    static let dbName = "tasks.sqlite3"
}

// MARK: - Add Command

extension TaskManager {
    struct Add: ParsableCommand {

        static let configuration = CommandConfiguration(
            abstract: "Add a new task to the task list."
        )

        @Option(name: .shortAndLong, help: "The title of the task to add.")
        var title: String

        func run() throws {
            let db = try Connection(TaskManager.dbName)
            let tasksTable = Table("tasks")
            let expressions = TaskExpressions()
            try db.run(tasksTable.create(ifNotExists: true) { t in 
                t.column(expressions.id, primaryKey: .autoincrement)
                t.column(expressions.title)
                t.column(expressions.isCompleted, defaultValue: false)
                t.column(expressions.createdAt, defaultValue: Date())
            })
            
            let query = tasksTable.insert(expressions.title <- title)
            let rowId = try db.run(query)
            print("Task added with ID: \(rowId)")
        }
    }
}

// MARK: - List Command

extension TaskManager {
    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Show the task list."
        )

        func run() throws {
            let db = try Connection(TaskManager.dbName)
            let tasksTable = Table("tasks")
            let expressions = TaskExpressions()
            
            for task in try db.prepare(tasksTable) {
                let status = task[expressions.isCompleted] ? "[x]" : "[ ]"
                print("\(task[expressions.id]): \(task[expressions.title]) \(status)")
            }
        }
    }
}

// MARK: - Complete Command

extension TaskManager {
    struct Complete: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Complete the task from the task list.",
            aliases: ["done"]
        )

        @Option(name: .shortAndLong, help: "The ID of the task to complete.")
        var id: Int64

        func run() throws {
            let db = try Connection(TaskManager.dbName)
            let tasksTable = Table("tasks")
            let expressions = TaskExpressions()
            
            let task = tasksTable.filter(expressions.id == id)
            if try db.run(task.update(expressions.isCompleted <- true)) > 0 {
                print("Task \(id) marked as completed.")
            } else {
                print("Task with ID \(id) not found.")
            }
        }
    }
}
