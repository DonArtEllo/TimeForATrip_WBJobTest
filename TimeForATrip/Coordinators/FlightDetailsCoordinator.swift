//
//  FlightDetailsCoordinator.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

final class FlightDetailsCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    var flightsDataPublisherFacade: FlightsDataPublisherFacade?
    var flightSearchToken: String
    
    private let factory: ControllerFactory
    private lazy var flightDetailsModule = {
        factory.makeFlightDetails()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
        self.flightSearchToken = ""
    }
    
    func start() {
        
        flightDetailsModule.viewModel.onShowFlights = {
            self.navigationController.popToRootViewController(animated: true)
        }
        flightDetailsModule.controller.flightsDataPublisherFacade = flightsDataPublisherFacade
        flightDetailsModule.controller.flightSearchToken = flightSearchToken
        navigationController.pushViewController(flightDetailsModule.controller, animated: true)
    }
}
