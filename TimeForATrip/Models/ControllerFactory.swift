//
//  ControllerFactory.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

protocol ControllerFactory {
    
    func makeFlights() -> (viewModel: FlightsModel, controller: FlightsViewController)
    
    func makeFlightDetails() -> (viewModel: FlightDetailsModel, controller: FlightDetailsViewController)
}

struct ControllerFactoryImpl: ControllerFactory {
    
    func makeFlights() -> (viewModel: FlightsModel, controller: FlightsViewController) {
        let viewModel = FlightsModel()
        let controller = FlightsViewController(viewModel: viewModel)

        return (viewModel, controller)
    }
    
    func makeFlightDetails() -> (viewModel: FlightDetailsModel, controller: FlightDetailsViewController) {
        let viewModel = FlightDetailsModel()
        let controller = FlightDetailsViewController(viewModel: viewModel)

        return (viewModel, controller)
    }
    
}

