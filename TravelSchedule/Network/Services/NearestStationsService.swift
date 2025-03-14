//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestStations = [Components.Schemas.Station]

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations?
}

final class NearestStationsService: NearestStationsServiceProtocol {
    
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations? {
        
        let response = try await client.getNearestStations(query: .init(
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json.stations
    }
}
