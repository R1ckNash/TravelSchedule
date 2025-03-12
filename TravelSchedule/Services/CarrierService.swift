//
//  CarrierService.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarriersResponse = Components.Schemas.CarriersResponse

protocol CarrierServiceProtocol {
    
    func getCarrier(code: String) async throws -> CarriersResponse
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getCarrier(code: String) async throws -> CarriersResponse {

        let response = try await client.getCarrier(query: .init(code: code))
        return try response.ok.body.json
    }
}
