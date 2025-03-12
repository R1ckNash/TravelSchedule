//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    
    func getSchedule(station: String) async throws -> ScheduleResponse
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getSchedule(station: String) async throws -> ScheduleResponse {

        let response = try await client.getSchedule(query: .init(
            station: station
        ))
        
        return try response.ok.body.json
    }
}
