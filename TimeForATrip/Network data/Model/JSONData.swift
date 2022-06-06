//
//  JSONData.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import Foundation

// MARK: - Flights
struct Flights: Decodable {
    let meta: MetaData
    let data: [Flight]
}

// MARK: - FlightData
struct Flight: Codable {
    let startCity: String
    let startCityCode: String
    let endCity, endCityCode: String
    let startDate, endDate: String
    let price: Int
    let searchToken: String
}

// MARK: - MetaData
struct MetaData: Decodable {
}
