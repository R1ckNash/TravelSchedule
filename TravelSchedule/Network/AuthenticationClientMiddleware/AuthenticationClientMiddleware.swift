//
//  AuthenticationClientMiddleware.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 12/03/2025.
//

import OpenAPIRuntime
import Foundation
import HTTPTypes

struct AuthenticationMiddleware {
    
    private let value: String
    
    init(authorizationHeaderFieldValue value: String) { self.value = value }
}

extension AuthenticationMiddleware: ClientMiddleware {
    
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        
        request.headerFields[.authorization] = value
        return try await next(request, body, baseURL)
    }
}
