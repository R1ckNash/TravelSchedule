//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsResponse = Components.Schemas.StationsResponse

protocol StationsListServiceProtocol {
    
    func getStationsList() async throws -> StationsResponse
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsResponse {
        
        let response = try await client.getStationsList(query: .init(
            apikey: self.apikey
        ))
        
        return try response.ok.body.json
    }
}
