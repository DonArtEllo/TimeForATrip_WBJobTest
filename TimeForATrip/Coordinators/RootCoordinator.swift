//
//  RootCoordinator.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

class RootCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    let tabBarController: TabBarController

    private let factory = ControllerFactoryImpl()

    init() {
        tabBarController = TabBarController()
        
        let flightsCoordinator = configureFlights()
        coordinators.append(flightsCoordinator)
        
        tabBarController.viewControllers = [flightsCoordinator.navigationController]
        
        flightsCoordinator.start()
    }
    
    private func configureFlights() -> FlightsCoordinator {
        let navigationFlights = UINavigationController()
        let coordinator = FlightsCoordinator(
            navigation: navigationFlights,
            factory: factory)
        
        return coordinator
    }
    
}
