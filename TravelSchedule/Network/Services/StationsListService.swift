//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsResponse = Components.Schemas.StationsResponse

protocol StationsListServiceProtocol {
    
    func getStationsList() async throws -> StationsResponse
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getStationsList() async throws -> StationsResponse {
        
           let response = try await client.getStationsList(query: .init(format: .json))
           
           switch try response.ok.body {
           case .html(let body):
               return try await convertHtmlToJson(body: body)
           case .json(let json):
               return json
           }
       }
       
       private func convertHtmlToJson(body: HTTPBody) async throws -> StationsResponse {
           
           let data = try await Data(collecting: body, upTo: .max)
           let result = try JSONDecoder().decode(StationsResponse.self, from: data)
           
           return result
       }
}
