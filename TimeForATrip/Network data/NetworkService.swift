//
//  NetworkService.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import Foundation

class NetworkService {
    
    let flightsDataPublisherFacade = FlightsDataPublisherFacade()
    var flightsList: [FlightData] = []
        
    public func getFlightsData(complition: @escaping ([FlightData]) -> Void) {

        if !flightsList.isEmpty {
            print("no need to load json again")
            complition(flightsList)
        }
        
        let apiURL = "https://travel.wildberries.ru/statistics/v1/cheap"
        
        guard let url = URL(string: apiURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                guard let error = error else {
                    print("UNKNOWN ERROR")
                    return
                }
                print("ERROR: \(error.localizedDescription)") // ERROR: The Internet connection appears to be offline.
                return
            }
            print("DATA: ")
            
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Flights.self, from: data)
                    if self.flightsList.isEmpty {
                        json.data.forEach { flight in
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                            let startDateFormated = dateFormatter.date(from: flight.startDate)
                            let endDateFormated = dateFormatter.date(from: flight.endDate)
                            
                            let internalFlight = FlightData(startCity: flight.startCity, startCityCode: flight.startCityCode, endCity: flight.endCity, endCityCode: flight.endCityCode, startDate: startDateFormated!, endDate: endDateFormated!, price: flight.price, searchToken: flight.searchToken, likeStatus: false)
                            
                            self.flightsList.append(internalFlight)
                        }
                    }
                    print(json.data)
                    self.flightsDataPublisherFacade.addFlightsData(flightsData: self.flightsList)
                    complition(self.flightsList)
                } catch {
                    print(error.localizedDescription)
                }
            }
            print("RESPONSE ALL HEADERFIELDS: \(urlResponse.allHeaderFields as! [String: Any])")
            print("RESPONSE STATUS: \(urlResponse.statusCode)")
        }.resume()
    }
}
