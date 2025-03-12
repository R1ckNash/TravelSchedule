//
//  ThreadService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationThreadsResponse = Components.Schemas.StationThreadsResponse

protocol ThreadServiceProtocol {
    
    func getThread(uid: String) async throws -> StationThreadsResponse
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getThread(uid: String) async throws -> StationThreadsResponse {
        
        let response = try await client.getThread(query: .init(uid: uid))
        return try response.ok.body.json
    }
}
