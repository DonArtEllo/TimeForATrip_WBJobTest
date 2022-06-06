//
//  FlightsDataPublisher.swift
//  TimeForATrip
//
//  Created by Артем on 02.06.2022.
//

import Foundation

public protocol FlightsDataLibrarySubscriber {
    
    func receive(flights: [FlightData])
}

final class FlightsDataPublisher {
    
    private var subscribers: [FlightsDataLibrarySubscriber] = []
    private var flights: [FlightData] = []
    
    func add(flight: FlightData) {
        flights.append(flight)
        notifySubscribers()
    }
    
    func remove(flight: FlightData) {
        guard let index = flights.firstIndex(where: { $0 == flight }) else { return }
        flights.remove(at: index)
        notifySubscribers()
    }
    
    func changeLikeStatusForFlight(flightSearchToken: String) {
        guard let index = flights.firstIndex(where: { $0.searchToken == flightSearchToken }) else { return }
        flights[index].likeStatus.toggle()
        notifySubscribers()
    }
    
    func checkLikeStatusForFlight(flightSearchToken: String) -> Bool {
        guard let index = flights.firstIndex(where: { $0.searchToken == flightSearchToken }) else { return false }
        return flights[index].likeStatus
    }
    
    func getFlightDataForFlight(flightSearchToken: String) -> FlightData {
        guard let index = flights.firstIndex(where: { $0.searchToken == flightSearchToken }) else { return FlightData(startCity: "City From", startCityCode: "CF", endCity: "City To", endCityCode: "CT", startDate: Date(), endDate: Date(), price: 0, searchToken: "", likeStatus: false) }
        return flights[index]
    }
    
    func removeAll() {
        if !flights.isEmpty {
            flights = []
        }
        notifySubscribers()
    }
    
    func add(subscriber: FlightsDataLibrarySubscriber) {
        subscribers.append(subscriber)
    }
    
    func remove(subscriber filter: (FlightsDataLibrarySubscriber) -> Bool) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }
    
    private func notifySubscribers() {
        subscribers.forEach {
            $0.receive(flights: flights)
        }
    }
}
