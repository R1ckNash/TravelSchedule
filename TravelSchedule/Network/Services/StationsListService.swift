//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation


typealias StationsList = Components.Schemas.Station

protocol StationsListServiceProtocol {
    
    func getListOfAllStations() async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func  getListOfAllStations() async  throws -> StationsList {
        let response = try await client.getStationsList()
        let httpBody = try response.ok.body.html
        let data = try await Data(collecting: httpBody, upTo: 100 * 1024 * 1024)
        let stationList = try JSONDecoder().decode(StationsList.self, from: data)
        return stationList
    }
}
