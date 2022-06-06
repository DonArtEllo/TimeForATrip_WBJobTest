//
//  FlightsTableView.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

final class FlightsTableView: UITableView {
    
    // MARK: - Initialization
    init(dataSource: UITableViewDataSource,
         delegate: UITableViewDelegate) {
        super.init(frame: .zero, style: .plain)
        
        register(FlightsTableViewCell.self, forCellReuseIdentifier: String(describing: FlightsTableViewCell.self))
        
        self.dataSource = dataSource
        self.delegate = delegate
        
        backgroundColor = UIColor(named: "WBPurplish")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
