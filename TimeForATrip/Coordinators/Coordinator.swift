//
//  Coordinator.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
