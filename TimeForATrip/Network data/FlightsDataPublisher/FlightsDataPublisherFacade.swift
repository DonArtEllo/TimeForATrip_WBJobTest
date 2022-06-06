//
//  FlightsDataPublisherFacade.swift
//  TimeForATrip
//
//  Created by Артем on 02.06.2022.
//

import Foundation

final public class FlightsDataPublisherFacade {
        
    private let publisher = FlightsDataPublisher()
    
    public init() {}
    
    /// добавляет подписчика
    public func subscribe(_ subscriber: FlightsDataLibrarySubscriber) {
        publisher.add(subscriber: subscriber)
    }
    
    /// удаляет подписчика
    public func removeSubscription(for subscriber: FlightsDataLibrarySubscriber) {
        publisher.remove { _ in
            return true
        }
    }
    
    /// добавляет массив данных о полётах в библиотеку
    public func addFlightsData(flightsData: [FlightData]) {
        flightsData.forEach { flightData in
            self.publisher.add(flight: flightData)
            
        }
    }
    
    /// меняет состояние лайка для определенного полета
    public func changeLikeStatius(forFlight flightToken: String) {
        self.publisher.changeLikeStatusForFlight(flightSearchToken: flightToken)
    }
    
    /// проверяет состояние лайка для определенного полета
    public func checkLikeStatus(forFlight flightToken: String) -> Bool {
        return self.publisher.checkLikeStatusForFlight(flightSearchToken: flightToken)
    }
    
    ///
    public func getFlightData(forFlight flightToken: String) -> FlightData {
        return self.publisher.getFlightDataForFlight(flightSearchToken: flightToken)
    }
    
    /// метод обнуляет библиотеку полётов
    public func rechargeFlightsDataLibrary() {
        publisher.removeAll()
    }
}
