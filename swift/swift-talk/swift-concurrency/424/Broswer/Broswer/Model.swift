//
//  DataBaseError.swift
//  Broswer
//
//  Created by Tao Xu on 11/4/24.
//

import Foundation
import SQLite3

struct DataBaseError: Error {
    var line: UInt
    var code: Int32
    var message: String
}

actor DataBase {
    var impl: DataBaseImpl
    init(url: URL) throws {
        impl = try DataBaseImpl(url: url)
    }
    func setup() throws {
        try impl.setup()
    }
    func insert(page: Page) throws {
        try impl.execute(query: "INSERT INTO PageData(id, title, url, lastUpdated, fullText, snapshot) VALUES (?, ?, ?, ?, ?, ?)",
                     params: page.id,
                     page.title,
                     page.url,
                     page.lastUpdated,
                     page.fullText,
                     page.snapshot)
    }
}

final class DataBaseImpl {
    var connection: OpaquePointer?
    init(url: URL) throws {
        var connection: OpaquePointer?
        try checkError {
            url.absoluteString.withCString { ptr in
                sqlite3_open(ptr, &connection)
            }
        }
        self.connection = connection
    }
    func setup() throws {
        
        let query = """
        CREATE TABLE PageData (
            id TEXT PRIMARY KEY NOT NULL,
            lastUpdated INTEGER NOT NULL,
            url TEXT NOT NULL,
            title TEXT NOT NULL,
            fullText TEXT,
            snapshot BLOB
        );
        """
        var statement: OpaquePointer?
        try checkError {
            query.withCString { ptr in
                sqlite3_prepare_v3(connection, ptr, -1, 0, &statement, nil)
            }
        }
        let code = sqlite3_step(statement)
        guard code == SQLITE_DONE else {
            try checkError { code }
            return //todo
        }
        try checkError {
            sqlite3_finalize(statement)
        }
        print("Done")
    }
    func execute(query: String, params: Bindable...) throws {
        var statement: OpaquePointer?
        try checkError {
            query.withCString { ptr in
                sqlite3_prepare_v3(connection, ptr, -1, 0, &statement, nil)
            }
        }
        for (param, ix) in zip(params, (1 as Int32)...) {
            try param.bind(to: statement, column: ix)
        }
        let code = sqlite3_step(statement)
        guard code == SQLITE_DONE else {
            try checkError { code }
            return //todo
        }
        try checkError {
            sqlite3_finalize(statement)
        }
    }
}

protocol Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws
}

extension Int64: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        try checkError {
            sqlite3_bind_int64(statement, column, self)
        }
    }
}

let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

extension String: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        try checkError {
            withCString {
                sqlite3_bind_text(statement, column, $0, -1, SQLITE_TRANSIENT)
            }
        }
    }
}

extension URL: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        try absoluteString.bind(to: statement, column: column)
    }
}

extension Date: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        try Int64(timeIntervalSince1970).bind(to: statement, column: column)
    }
}

extension UUID: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        try uuidString.bind(to: statement, column: column)
    }
}

extension Data: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        try checkError {
            withUnsafeBytes {
                sqlite3_bind_blob(statement, column, $0.baseAddress, Int32($0.count), SQLITE_TRANSIENT)
            }
        }
    }
}

extension Optional: Bindable where Wrapped: Bindable {
    func bind(to statement: OpaquePointer?, column: Int32) throws {
        switch self {
        case .none:
            sqlite3_bind_null(statement, column)
        case .some(let x):
            try x.bind(to: statement, column: column)
        }
    }
}

func checkError(line: UInt = #line, fn: ()->Int32) throws {
    let code = fn()
    guard code == SQLITE_OK else {
        let str = String(cString: sqlite3_errstr(code))
        throw DataBaseError(line: line, code: code, message: str)
    }
}
