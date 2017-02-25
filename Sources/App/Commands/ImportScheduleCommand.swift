//
//  ImportScheduleCommand.swift
//  SumDUBot
//
//  Created by Yura Voevodin on 11.02.17.
//
//

import Vapor
import Console
import HTTP
import Foundation

final class ImportScheduleCommand: Command {

    // MARK: - Constants

    public let id = "importSchedule"
    public let help = ["This command imports data about schedule"]
    public let console: ConsoleProtocol

    // MARK: - Variables

    fileprivate var droplet: Droplet?

    // MARK: - Initialization

    public init(console: ConsoleProtocol, droplet: Droplet) {
        self.console = console
        self.droplet = droplet
    }

    // MARK: - Public interface

    public func run(arguments: [String]) throws {
        // Fetch objects
        let objects = try Object.query().limit(100, withOffset: 0).run()

        for object in objects {
            // Make request and node from JSON response
            let json = try makeRequestOfSchedule(for: object)
            if let node = json?.makeNode(), let id = object.id {

                // Try to delete old records
                try object.records().delete()

                // Import new records
                try ScheduleRecordImportManager().importFrom(node: node, for: id)
            }
        }
    }
}

// MARK: - Helpers

extension ImportScheduleCommand {

    /// Make request of schedule for object
    ///
    /// - Parameter object: for which get schedule
    /// - Returns: schedule as json
    fileprivate func makeRequestOfSchedule(for object: Object) throws -> JSON? {
        // Detect type of object
        guard let type = ObjectType(rawValue: object.type) else {
            print("❌ Failed to detect type of object")
            return nil
        }
        var groupId = "0"
        var teacherId = "0"
        var auditoriumId = "0"
        switch type {
        case .auditorium:
            auditoriumId = String(object.serverID)
        case .group:
            groupId = String(object.serverID)
        case .teacher:
            teacherId = String(object.serverID)
        }

        // Time interval for request
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(60*60*24*7)

        // Query parameters
        let query: [String: CustomStringConvertible] = [
            "data[DATE_BEG]": startDate.serverDateFormat,
            "data[DATE_END]": endDate.serverDateFormat,
            "data[KOD_GROUP]": groupId,
            "data[ID_FIO]": teacherId,
            "data[ID_AUD]": auditoriumId
        ]

        let response = try drop.client.post("http://schedule.sumdu.edu.ua/index/json", query: query)
        return response.json
    }
}
