//
//  Teacher.swift
//  SumDUBot
//
//  Created by Yura Voevodin on 15.04.17.
//
//

import Vapor
import FluentPostgreSQL

final class Teacher: ListObject {
    var id: Int?
    
    
    // MARK: Properties
    
    var serverID: Int
    var name: String
    var updatedAt: String
    var lowercaseName: String
    
    // MARK: - Initialization
    
    init(serverID: Int, name: String, updatedAt: String, lowercaseName: String) {
        self.serverID = serverID
        self.name = name
        self.updatedAt = updatedAt
        self.lowercaseName = lowercaseName
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes the ListObject from the
    /// database row
//    required init(row: Row) throws {
//        serverID = try row.get(Field.serverID.name)
//        name = try row.get(Field.name.name)
//        updatedAt = try row.get(Field.updatedAt.name)
//        lowercaseName = try row.get(Field.lowercaseName.name)
//    }
//
//    /// Serializes the ListObject to the database
//    func makeRow() throws -> Row {
//        var row = Row()
//        try row.set(Field.serverID.name, serverID)
//        try row.set(Field.name.name, name)
//        try row.set(Field.updatedAt.name, updatedAt)
//        try row.set(Field.lowercaseName.name, lowercaseName)
//        return row
//    }
}

// MARK: - Relationships

//extension Teacher {
//    var records: Children<Teacher, Record> {
//        return children()
//    }
//}

// MARK: - Helpers

extension Teacher {
    
//    static func find(by name: String?) throws -> [InlineKeyboardButton] {
//        guard let name = name else { return [] }
//        guard name.count > 3 else { return [] }
//        var response: [InlineKeyboardButton] = []
//        let teachers = try Teacher.makeQuery().filter(Field.lowercaseName.name, .contains, name.lowercased()).all()
//        let prefix = ObjectType.teacher.prefix
//        for teacher in teachers {
//            let button = InlineKeyboardButton(text: teacher.name, callbackData: prefix + "\(teacher.serverID)")
//            response.append(button)
//        }
//        return response
//    }
    
//    static func find(by name: String) throws -> [Button] {
//        guard name.count > 3 else { return [] }
//        var buttons: [Button] = []
//        let teachers = try Teacher.makeQuery().filter(Field.lowercaseName.name, .contains, name.lowercased()).all()
//        for teacher in teachers {
//            let payload = ObjectType.teacher.prefix + "\(teacher.serverID)"
//            let auditoriumButton = try Button(type: .postback, title: teacher.name, payload: payload)
//            buttons.append(auditoriumButton)
//        }
//        return buttons
//    }
    
//    static func show(for message: String, chatID: Int? = nil, client: ClientFactoryProtocol) throws -> [String] {
//        // Get ID of teacher from message (/teacher_{id})
//        let idString = message[message.index(message.startIndex, offsetBy: 9)...]
//        guard let id = Int(idString) else { return [] }
//
//        // Find records for teachers
//        guard let teacher = try Teacher.makeQuery().filter(Field.serverID.name, id).first() else { return [] }
//        let currentHour = Date().dateWithHour
//        if teacher.updatedAt != currentHour {
//            // Try to delete old records
//            try teacher.records.delete()
//
//            // Try to import schedule
//            try ScheduleImportManager.importSchedule(for: .teacher, id: teacher.serverID, client: client)
//
//            // Update date in object
//            teacher.updatedAt = currentHour
//            try teacher.save()
//        }
//
//        // Register request for user
//        if let chatID = chatID, let id = teacher.id {
//            BotUser.registerRequest(chatID: chatID, objectID: id, type: .teacher)
//        }
//
//        let records = try teacher.records
//            .sort("date", .ascending)
//            .sort("pair_name", .ascending)
//            .all()
//
//        return try Record.prepareResponse(for: records)
//    }
}
