//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Ilia Liasin on 07/03/2025.
//

import SwiftUI
import OpenAPIURLSession

let client = Client(
    serverURL: try! Servers.Server1.url(),
    transport: URLSessionTransport(),
    middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: Secrets.apiKey)]
)

struct ContentView: View {
    
    let nearestStationsService = NearestStationsService(client: client)
    let stationsListService = StationsListService(client: client)
    let carrierService = CarrierService(client: client)
    let copyrightService = CopyrightService(client: client)
    let threadService = ThreadService(client: client)
    let nearestSettlementService = NearestSettlementService(client: client)
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            getNearestStations()
            getAllStations()
            getCarrier()
            getThread()
            getCopyright()
            getNearestSettlement()
        }
    }
}

#Preview {
    ContentView()
}

// MARK: - Requests

extension ContentView {
    
    func getNearestStations() {
        Task {
            let stations = try await nearestStationsService.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50) ?? []
            print("near stations -> \(stations)")
        }
    }
    
    func getAllStations() {
        Task {
            let stations = try await stationsListService.getListOfAllStations()
            print("all stations -> \(stations)")
        }
    }
    
    func getCarrier() {
        Task {
            let carrier = try await carrierService.getCarrier(code: "680")
            print("carrier -> \(carrier)")
        }
    }
    
    func getCopyright() {
        Task {
            let copyright = try await copyrightService.getCopyright()
            print("copyright -> \(copyright)")
        }
    }
    
    func getThread() {
        Task {
            let thread = try await threadService.getThread(uid: "068S_2_2")
            print("thread -> \(thread)")
        }
    }
    
    func getNearestSettlement() {
        Task {
            let settlement = try await nearestSettlementService.getNearestSettlement(
                lat: 54.106677,
                lng: 39.601726,
                distance: 50)
            print("settlement -> \(settlement)")
        }
    }
}

