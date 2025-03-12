//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResponse = Components.Schemas.SearchResponse

protocol SearchServiceProtocol {
    
    func search(from: String, to: String) async throws -> SearchResponse
}

final class SearchService: SearchServiceProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func search(from: String, to: String) async throws -> SearchResponse {
        
        let response = try await client.getSearch(query: .init(
            from: from,
            to: to
        ))
        
        return try response.ok.body.json
    }
}
