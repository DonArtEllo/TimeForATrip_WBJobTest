//
//  FlightsTableViewCell.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

final class FlightsTableViewCell: UITableViewCell {
        
    // MARK: Data from parent
    var flightFromParent: FlightData? {
        didSet {
            if let flightInfo = flightFromParent {
                let dateToStringFormatter = DateFormatter()
                dateToStringFormatter.dateFormat = "dd.MM.yyyy - HH:mm"
                
                self.startCityNameLabel.text = flightInfo.startCity
                self.startCityCodeLabel.text = flightInfo.startCityCode
                self.endCityNameLabel.text = flightInfo.endCity
                self.endCityCodeLabel.text = flightInfo.endCityCode
                self.startDateLabel.text = dateToStringFormatter.string(from: flightInfo.startDate.toLocalTime())
                self.endDateLabel.text = dateToStringFormatter.string(from: flightInfo.endDate.toLocalTime())
                self.priceLabel.text = String(flightInfo.price) + "₽"
                self.flightToken = flightInfo.searchToken
            }
        }
    }
    
    var flightToken: String = ""
    var flightsDataPublisherFacade: FlightsDataPublisherFacade?

    // MARK: - Content
    // Label for flight's start city name
    private let startCityNameLabel: UILabel = {
        let startCityNameLabel = UILabel()
        startCityNameLabel.text = "City From"
        startCityNameLabel.font = .boldSystemFont(ofSize: 28)
        startCityNameLabel.contentMode = .scaleAspectFill
        startCityNameLabel.clipsToBounds = true
        
        return startCityNameLabel
    }()
    
    // Label for flight's start city code
    private let startCityCodeLabel: UILabel = {
        let startCityCodeLabel = UILabel()
        startCityCodeLabel.text = "CF"
        startCityCodeLabel.font = .boldSystemFont(ofSize: 20)
        startCityCodeLabel.contentMode = .scaleAspectFill
        startCityCodeLabel.clipsToBounds = true
        
        return startCityCodeLabel
    }()

    // Label for flight's end city name
    private let endCityNameLabel: UILabel = {
        let endCityNameLabel = UILabel()
        endCityNameLabel.text = "City To"
        endCityNameLabel.font = .boldSystemFont(ofSize: 28)
        endCityNameLabel.contentMode = .scaleAspectFill
        endCityNameLabel.clipsToBounds = true
        
        return endCityNameLabel
    }()
    
    // Label for flight's end city code
    private let endCityCodeLabel: UILabel = {
        let endCityCodeLabel = UILabel()
        endCityCodeLabel.text = "CT"
        endCityCodeLabel.font = .boldSystemFont(ofSize: 20)
        endCityCodeLabel.contentMode = .scaleAspectFill
        endCityCodeLabel.clipsToBounds = true
        
        return endCityCodeLabel
    }()
    
    // Label for flight's start date and time
    private let startDateLabel: UILabel = {
        let startDateLabel = UILabel()
        startDateLabel.text = "Today"
        startDateLabel.font = .systemFont(ofSize: 16)
        startDateLabel.contentMode = .scaleAspectFill
        startDateLabel.clipsToBounds = true
        
        return startDateLabel
    }()
    
    // Label for flight's start date and time
    private let endDateLabel: UILabel = {
        let endDateLabel = UILabel()
        endDateLabel.text = "Tomorrow"
        endDateLabel.font = .systemFont(ofSize: 16)
        endDateLabel.contentMode = .scaleAspectFill
        endDateLabel.clipsToBounds = true
        
        return endDateLabel
    }()
    
    // Label for flight's price
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "100 $"
        priceLabel.font = .boldSystemFont(ofSize: 32)
        priceLabel.contentMode = .scaleAspectFill
        priceLabel.clipsToBounds = true
        
        return priceLabel
    }()
    
    // Button for Like status
    private let likeButton: LikeButton = {
        let likeButton = LikeButton(frame:
                                            CGRect(
                                                x: 0,
                                                y: 0,
                                                width: 1,
                                                height: 1
                                            )
        )
        likeButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        likeButton.isUserInteractionEnabled = true
        
        return likeButton
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        setupViews()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        flightsDataPublisherFacade?.removeSubscription(for: self)
        flightsDataPublisherFacade?.rechargeFlightsDataLibrary()
    }
    
    // MARK: - Functions
    // Setup views
    func setupViews() {
        
        contentView.addSubviews(
            startCityNameLabel,
            startDateLabel,
            endCityNameLabel,
            endDateLabel,
            likeButton,
            priceLabel
        )
        
        // MARK: Constrains
        var contentViewHeight = contentView.heightAnchor.constraint(equalToConstant: 160)
        if let contentHeight = superview?.bounds.height {
            contentViewHeight = contentView.heightAnchor.constraint(equalToConstant: (contentHeight) / 4)
        }
       
        contentViewHeight.priority = .defaultHigh
                
        let constraints = [
            contentViewHeight,
            
            startCityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            startCityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            startCityNameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            startDateLabel.topAnchor.constraint(equalTo: startCityNameLabel.bottomAnchor, constant: 4),
            startDateLabel.leadingAnchor.constraint(equalTo: startCityNameLabel.leadingAnchor),
            startDateLabel.heightAnchor.constraint(equalToConstant: 16),
            
            endDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            endDateLabel.leadingAnchor.constraint(equalTo: startCityNameLabel.leadingAnchor),
            endDateLabel.heightAnchor.constraint(equalToConstant: 16),
            
            endCityNameLabel.bottomAnchor.constraint(equalTo: endDateLabel.topAnchor, constant: -4),
            endCityNameLabel.leadingAnchor.constraint(equalTo: startCityNameLabel.leadingAnchor),
            endCityNameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            priceLabel.topAnchor.constraint(equalTo: startCityNameLabel.topAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.heightAnchor.constraint(equalToConstant: 64),
            
            likeButton.bottomAnchor.constraint(equalTo: endDateLabel.bottomAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addFacadeSubscription() {
        flightsDataPublisherFacade?.subscribe(self)
    }
    
    private func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnLikeButton))
        likeButton.addGestureRecognizer(gesture)
    }
    
    // Tap on Like Button
    @objc func didTapOnLikeButton() {
        print("button pressed")
        flightsDataPublisherFacade?.changeLikeStatius(forFlight: self.flightToken)
    }
    
    // Changing Like button color
    func changeButtonColor(likeStatus: Bool) {
        likeButton.toggleLike(newLikeStatus: likeStatus)
    }
}

extension FlightsTableViewCell: FlightsDataLibrarySubscriber {
    func receive(flights: [FlightData]) {
        guard let index = flights.firstIndex(where: { $0.searchToken == self.flightToken }) else { return }

        self.changeButtonColor(likeStatus: flights[index].likeStatus)
    }
}
