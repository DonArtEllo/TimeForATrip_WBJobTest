//
//  FlightDetailsModel.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import Foundation

protocol FlightDetailsViewOutput {
    var onTapShowFlights: () -> Void { get }
}

final class FlightDetailsModel: FlightDetailsViewOutput {
    
    var onShowFlights: (() -> Void)?
    
    lazy var onTapShowFlights: () -> Void = { [weak self] in
        self?.onShowFlights?()
    }
}
