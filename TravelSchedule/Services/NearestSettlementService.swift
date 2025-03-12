//
//  NearestSettlementService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlementResponse = Components.Schemas.NearestSettlementResponse

protocol NearestSettlementServiceProtocol {
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlementResponse
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlementResponse {
        
        let response = try await client.getNearestSettlement(query: .init(
            lat: lat,
            lng: lng,
            distance: distance,
            apikey: self.apikey
        ))
        
        return try response.ok.body.json
    }
}
