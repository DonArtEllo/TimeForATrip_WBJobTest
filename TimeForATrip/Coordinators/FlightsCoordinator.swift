//
//  FlightsCoordinator.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

final class FlightsCoordinator: Coordinator {
    
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    
    private let factory: ControllerFactory
    private lazy var flightsModule = {
        factory.makeFlights()
    }()
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        
        flightsModule.viewModel.onShowFlightDetails = { flightSearchToken in
            let flightDetailsCoordinator = FlightDetailsCoordinator(navigation: self.navigationController, factory: self.factory)
            flightDetailsCoordinator.flightsDataPublisherFacade = self.flightsModule.viewModel.networkService.flightsDataPublisherFacade
            flightDetailsCoordinator.flightSearchToken = flightSearchToken
            flightDetailsCoordinator.start()
        }
        
        navigationController.pushViewController(flightsModule.controller, animated: true)
    }
}
