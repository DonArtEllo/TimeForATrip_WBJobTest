//
//  FlightDetailsViewController.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit

class FlightDetailsViewController: UIViewController {

    var viewModel: FlightDetailsViewOutput
    var flightSearchToken: String = ""
    
    var flightsDataPublisherFacade: FlightsDataPublisherFacade?

    // MARK: - Content
    // Content view
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor(named: "WBGrey1")
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    // Label for forward flight's start city name
    private let forwardFlightStartCityNameLabel: UILabel = {
        let forwardFlightStartCityNameLabel = UILabel()
        forwardFlightStartCityNameLabel.text = "FF City From"
        forwardFlightStartCityNameLabel.font = .boldSystemFont(ofSize: 30)
        forwardFlightStartCityNameLabel.textAlignment = .left
        
        return forwardFlightStartCityNameLabel
    }()
    
    // Label for forward flight's start city code
    private let forwardFlightStartCityCodeLabel: UILabel = {
        let forwardFlightStartCityCodeLabel = UILabel()
        forwardFlightStartCityCodeLabel.text = "FF-CF"
        forwardFlightStartCityCodeLabel.font = .boldSystemFont(ofSize: 20)
        forwardFlightStartCityCodeLabel.textAlignment = .left
        
        return forwardFlightStartCityCodeLabel
    }()

    // Label for forward flight's start city name
    private let forwardFlightEndCityNameLabel: UILabel = {
        let forwardFlightEndCityNameLabel = UILabel()
        forwardFlightEndCityNameLabel.text = "FF City To"
        forwardFlightEndCityNameLabel.font = .boldSystemFont(ofSize: 30)
        forwardFlightEndCityNameLabel.textAlignment = .left
        
        return forwardFlightEndCityNameLabel
    }()
    
    // Label for forward flight's end city code
    private let forwardFlightEndCityCodeLabel: UILabel = {
        let forwardFlightEndCityCodeLabel = UILabel()
        forwardFlightEndCityCodeLabel.text = "FF-CT"
        forwardFlightEndCityCodeLabel.font = .boldSystemFont(ofSize: 20)
        forwardFlightEndCityCodeLabel.textAlignment = .left
        
        return forwardFlightEndCityCodeLabel
    }()
    
    // Label for forward flight's date
    private let forwardFlightDateLabel: UILabel = {
        let forwardFlightDateLabel = UILabel()
        forwardFlightDateLabel.text = "Today"
        forwardFlightDateLabel.font = .systemFont(ofSize: 20)
        forwardFlightDateLabel.textAlignment = .left
        
        return forwardFlightDateLabel
    }()
    
    // Label for forward flight's start city name
    private let backFlightStartCityNameLabel: UILabel = {
        let backFlightStartCityNameLabel = UILabel()
        backFlightStartCityNameLabel.text = "BF City From"
        backFlightStartCityNameLabel.font = .boldSystemFont(ofSize: 30)
        backFlightStartCityNameLabel.textAlignment = .right
        
        return backFlightStartCityNameLabel
    }()
    
    // Label for forward flight's start city code
    private let backFlightStartCityCodeLabel: UILabel = {
        let backFlightStartCityCodeLabel = UILabel()
        backFlightStartCityCodeLabel.text = "BF-CF"
        backFlightStartCityCodeLabel.font = .boldSystemFont(ofSize: 20)
        backFlightStartCityCodeLabel.textAlignment = .right
        
        return backFlightStartCityCodeLabel
    }()

    // Label for back flight's start city name
    private let backFlightEndCityNameLabel: UILabel = {
        let backFlightEndCityNameLabel = UILabel()
        backFlightEndCityNameLabel.text = "BF City To"
        backFlightEndCityNameLabel.font = .boldSystemFont(ofSize: 30)
        backFlightEndCityNameLabel.textAlignment = .right
        
        return backFlightEndCityNameLabel
    }()
    
    // Label for back flight's end city code
    private let backFlightEndCityCodeLabel: UILabel = {
        let backFlightEndCityCodeLabel = UILabel()
        backFlightEndCityCodeLabel.text = "BF-CT"
        backFlightEndCityCodeLabel.font = .boldSystemFont(ofSize: 20)
        backFlightEndCityCodeLabel.textAlignment = .right
        
        return backFlightEndCityCodeLabel
    }()
    
    // Label for back flight's date
    private let backFlightDateLabel: UILabel = {
        let backFlightDateLabel = UILabel()
        backFlightDateLabel.text = "Tomorrow"
        backFlightDateLabel.font = .systemFont(ofSize: 20)
        backFlightDateLabel.textAlignment = .right
        
        return backFlightDateLabel
    }()
    
    // Label for flights' price
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "100 $"
        priceLabel.font = .boldSystemFont(ofSize: 32)
        priceLabel.textAlignment = .center
        
        return priceLabel
    }()
    
    // Button for Like status
    private let likeButton: LikeButtonView = {
        let likeButton = LikeButtonView(frame:
                                            CGRect(
                                                x: 0,
                                                y: 0,
                                                width: 1,
                                                height: 1
                                            )
        )
        likeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        likeButton.isUserInteractionEnabled = true
        
        return likeButton
    }()
    
    // Taking off plane image for forward flight
    private let forwardTakeOffImage: UIImageView = {
        let takeOffPlaneImageView = UIImageView()
        takeOffPlaneImageView.image = UIImage(systemName: "airplane.departure")
        takeOffPlaneImageView.tintColor = .black
        
        return takeOffPlaneImageView
    }()
    
    // Landing plane image for forward flight
    private let forwardLandImage: UIImageView = {
        let landPlaneImageView = UIImageView()
        landPlaneImageView.image = UIImage(systemName: "airplane.arrival")
        landPlaneImageView.tintColor = .black
        
        return landPlaneImageView
    }()
    
    // Taking off plane image for back flight
    private let backTakeOffImage: UIImageView = {
        let takeOffPlaneImageView = UIImageView()
        takeOffPlaneImageView.image = UIImage(systemName: "airplane.departure")
        takeOffPlaneImageView.tintColor = .black
        
        return takeOffPlaneImageView
    }()
    
    // Landing plane image for back flight
    private let backLandImage: UIImageView = {
        let landPlaneImageView = UIImageView()
        landPlaneImageView.image = UIImage(systemName: "airplane.arrival")
        landPlaneImageView.tintColor = .black
        
        return landPlaneImageView
    }()
    
    // Up & down arrows image
    private let arrowsImageView: UIImageView = {
        let arrowsImageView = UIImageView()
        arrowsImageView.image = UIImage(systemName: "arrow.up.arrow.down")
        arrowsImageView.tintColor = .black
        
        return arrowsImageView
    }()
    
    // MARK: - Initialization
    init(viewModel: FlightDetailsViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flightsDataPublisherFacade?.subscribe(self)
                
        setupViews()
        setupGestures()
        downloadFlightData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        flightsDataPublisherFacade?.removeSubscription(for: self)
    }
    
    // MARK: - Functions
    // Setup views
    func setupViews() {
        view.backgroundColor = UIColor(named: "WBPurplish")
        
        view.addSubview(contentView)
        
        contentView.addSubviews(
            forwardFlightStartCityNameLabel,
            forwardFlightEndCityNameLabel,
            forwardFlightDateLabel,
            forwardTakeOffImage,
            forwardFlightStartCityCodeLabel,
            forwardLandImage,
            forwardFlightEndCityCodeLabel,
            
            arrowsImageView,
            
            backFlightStartCityNameLabel,
            backFlightEndCityNameLabel,
            backFlightDateLabel,
            backTakeOffImage,
            backFlightStartCityCodeLabel,
            backLandImage,
            backFlightEndCityCodeLabel,

            priceLabel,
            likeButton
        )
        
        contentView.backgroundColor = UIColor(named: "WBGrey1")
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
        
        // MARK: Constrains
        let constraints = [
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4),

            // Forward flight
            forwardFlightStartCityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            forwardFlightStartCityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            forwardFlightStartCityNameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            forwardFlightEndCityNameLabel.topAnchor.constraint(equalTo: forwardFlightStartCityNameLabel.bottomAnchor, constant: 4),
            forwardFlightEndCityNameLabel.leadingAnchor.constraint(equalTo: forwardFlightStartCityNameLabel.leadingAnchor),
            forwardFlightEndCityNameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            forwardFlightDateLabel.topAnchor.constraint(equalTo: forwardFlightEndCityNameLabel.bottomAnchor, constant: 4),
            forwardFlightDateLabel.leadingAnchor.constraint(equalTo: forwardFlightStartCityNameLabel.leadingAnchor),
            forwardFlightDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            forwardTakeOffImage.topAnchor.constraint(equalTo: forwardFlightDateLabel.bottomAnchor, constant: 4),
            forwardTakeOffImage.leadingAnchor.constraint(equalTo: forwardFlightStartCityNameLabel.leadingAnchor),
            forwardTakeOffImage.heightAnchor.constraint(equalToConstant: 20),
            
            forwardFlightStartCityCodeLabel.topAnchor.constraint(equalTo: forwardTakeOffImage.topAnchor),
            forwardFlightStartCityCodeLabel.leadingAnchor.constraint(equalTo: forwardTakeOffImage.trailingAnchor, constant: 8),
            forwardFlightStartCityCodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            forwardLandImage.topAnchor.constraint(equalTo: forwardTakeOffImage.bottomAnchor, constant: 4),
            forwardLandImage.leadingAnchor.constraint(equalTo: forwardFlightStartCityNameLabel.leadingAnchor),
            forwardLandImage.heightAnchor.constraint(equalToConstant: 20),
            
            forwardFlightEndCityCodeLabel.topAnchor.constraint(equalTo: forwardLandImage.topAnchor),
            forwardFlightEndCityCodeLabel.leadingAnchor.constraint(equalTo: forwardLandImage.trailingAnchor, constant: 8),
            forwardFlightEndCityCodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            arrowsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            arrowsImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -96),
            arrowsImageView.heightAnchor.constraint(equalToConstant: 64),
            arrowsImageView.widthAnchor.constraint(equalToConstant: 64),
            
            // Back flight
            backFlightStartCityNameLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -32),
            backFlightStartCityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backFlightStartCityNameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            backFlightEndCityNameLabel.topAnchor.constraint(equalTo: backFlightStartCityNameLabel.bottomAnchor, constant: 4),
            backFlightEndCityNameLabel.trailingAnchor.constraint(equalTo: backFlightStartCityNameLabel.trailingAnchor),
            backFlightEndCityNameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            backFlightDateLabel.topAnchor.constraint(equalTo: backFlightEndCityNameLabel.bottomAnchor, constant: 4),
            backFlightDateLabel.trailingAnchor.constraint(equalTo: backFlightStartCityNameLabel.trailingAnchor),
            backFlightDateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            backTakeOffImage.topAnchor.constraint(equalTo: backFlightDateLabel.bottomAnchor, constant: 4),
            backTakeOffImage.trailingAnchor.constraint(equalTo: backFlightStartCityNameLabel.trailingAnchor),
            backTakeOffImage.heightAnchor.constraint(equalToConstant: 20),
            
            backFlightStartCityCodeLabel.topAnchor.constraint(equalTo: backTakeOffImage.topAnchor),
            backFlightStartCityCodeLabel.trailingAnchor.constraint(equalTo: backTakeOffImage.leadingAnchor, constant: -8),
            backFlightStartCityCodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            backLandImage.topAnchor.constraint(equalTo: backTakeOffImage.bottomAnchor, constant: 4),
            backLandImage.trailingAnchor.constraint(equalTo: backFlightStartCityNameLabel.trailingAnchor),
            backLandImage.heightAnchor.constraint(equalToConstant: 20),
            
            backFlightEndCityCodeLabel.topAnchor.constraint(equalTo: backLandImage.topAnchor),
            backFlightEndCityCodeLabel.trailingAnchor.constraint(equalTo: backLandImage.leadingAnchor, constant: -8),
            backFlightEndCityCodeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -8),
            priceLabel.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: likeButton.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // Downloading data from publisher via facade
    func downloadFlightData() {
        if let flightData = flightsDataPublisherFacade?.getFlightData(forFlight: flightSearchToken) {
            let dateToStringFormatter = DateFormatter()
            dateToStringFormatter.dateFormat = "dd.MM.yyyy"
            
            self.forwardFlightStartCityNameLabel.text = "Из: " + flightData.startCity
            self.forwardFlightEndCityNameLabel.text = "В: " + flightData.endCity
            self.forwardFlightStartCityCodeLabel.text = flightData.startCityCode.uppercased()
            self.forwardFlightEndCityCodeLabel.text = flightData.endCityCode.uppercased()
            self.forwardFlightDateLabel.text = "Дата полёта " + dateToStringFormatter.string(from: flightData.startDate.toLocalTime())
            
            self.backFlightStartCityNameLabel.text = "Из: " + flightData.endCity
            self.backFlightEndCityNameLabel.text = "В: " + flightData.startCity
            self.backFlightStartCityCodeLabel.text = flightData.endCityCode.uppercased()
            self.backFlightEndCityCodeLabel.text = flightData.startCityCode.uppercased()
            self.backFlightDateLabel.text = "Дата полёта " + dateToStringFormatter.string(from: flightData.endDate.toLocalTime())
            
            self.priceLabel.text = "Цена билетов: " + String(flightData.price) + "₽"
            self.flightSearchToken = flightData.searchToken
            self.changeButtonColor(likeStatus: flightData.likeStatus)
            
            self.navigationItem.title = flightData.startCity + " - " + flightData.endCity
        }
    }
    
    // MARK: Gestures
    private func setupGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnLikeButton))
        likeButton.addGestureRecognizer(gesture)
    }
    
    // Tap on Like Button
    @objc func didTapOnLikeButton() {
        flightsDataPublisherFacade?.changeLikeStatius(forFlight: self.flightSearchToken)
    }
    
    // Changing Like button color
    func changeButtonColor(likeStatus: Bool) {
        likeButton.toggleLike(newLikeStatus: likeStatus)
    }

}

// MARK: - Extensions
extension FlightDetailsViewController: FlightsDataLibrarySubscriber {
    func receive(flights: [FlightData]) {
        guard let index = flights.firstIndex(where: { $0.searchToken == self.flightSearchToken }) else { return }
        self.changeButtonColor(likeStatus: flights[index].likeStatus)
    }
}

