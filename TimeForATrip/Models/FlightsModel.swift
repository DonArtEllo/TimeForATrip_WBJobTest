//
//  FlightsModel.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import Foundation

protocol FlightsViewOutput {
    var onTapShowFlightDetails: (_ flightSearchToken: String) -> Void { get }
    var networkService: NetworkService { get set }
}

final class FlightsModel: FlightsViewOutput {
    
    var onShowFlightDetails: ((_ flightToken: String) -> Void)?
    
    lazy var onTapShowFlightDetails: (_ flightSearchToken: String) -> Void = { flightSearchToken in
        self.onShowFlightDetails?(flightSearchToken)
    }
    
    var networkService = NetworkService()    
}
