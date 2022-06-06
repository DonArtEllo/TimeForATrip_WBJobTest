//
//  InternalData.swift
//  TimeForATrip
//
//  Created by Артем on 02.06.2022.
//

import Foundation

// MARK: - Flight data for use inside app
public struct FlightData: Equatable {
    let startCity: String
    let startCityCode: String
    let endCity, endCityCode: String
    let startDate, endDate: Date
    let price: Int
    let searchToken: String
    var likeStatus: Bool
}
