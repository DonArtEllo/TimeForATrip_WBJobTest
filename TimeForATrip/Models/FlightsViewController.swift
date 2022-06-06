//
//  FlightsViewController.swift
//  TimeForATrip
//
//  Created by Артем on 31.05.2022.
//

import UIKit
import GIFImageView

class FlightsViewController: UIViewController {

    var viewModel: FlightsViewOutput
    
    // MARK: - Content
    // Tableview for flights
    private lazy var flightsTableView = FlightsTableView(dataSource: self, delegate: self)
    
    // View for loading animation
    private var fullscreenBackgroundView: UIView = {
        let fullscreenBackgroundView = UIView()
        fullscreenBackgroundView.backgroundColor = UIColor(named: "WBPurplish")
        fullscreenBackgroundView.alpha = 1
        
        fullscreenBackgroundView.isUserInteractionEnabled = false
        fullscreenBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return fullscreenBackgroundView
    }()
    
    // Image for loading animation
    private let loadingimage: UIImageView = {
        let loadingimage = UIImageView()
        loadingimage.image = UIImage.animatedImage(named: "loading-buffering")
        loadingimage.alpha = 1

        loadingimage.isUserInteractionEnabled = false
        loadingimage.translatesAutoresizingMaskIntoConstraints = false
        return loadingimage
    }()
    
    // MARK: - Initialization
    init(viewModel: FlightsViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        reloadTableData()
    }
    
    // Setup Navigation Bar
    private func setupNavigationBar() {
        self.navigationItem.backButtonDisplayMode = .minimal
        self.navigationItem.title = "Purple Cherry Airlines"
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "WBPurplish")
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "WBGrey0") ?? UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        self.navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "WBPurplish")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "WBGrey0")
    }
    
    // Setup all views
    private func setupViews() {
        view.backgroundColor = UIColor(named: "WBPurplish")
        view.addSubviews(
            flightsTableView,
            fullscreenBackgroundView,
            loadingimage
        )
        fullscreenBackgroundView.frame = .init(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )
        
        // MARK: Constraints
        let constraints = [
            fullscreenBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            fullscreenBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            fullscreenBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fullscreenBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadingimage.centerXAnchor.constraint(equalTo: fullscreenBackgroundView.centerXAnchor),
            loadingimage.centerYAnchor.constraint(equalTo: fullscreenBackgroundView.centerYAnchor),
            loadingimage.widthAnchor.constraint(equalToConstant: 100),
            loadingimage.heightAnchor.constraint(equalToConstant: 100),

            flightsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flightsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            flightsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            flightsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // Reload TableView's Data
    func reloadTableData() {
        viewModel.networkService.getFlightsData { _ in
            DispatchQueue.main.async {
                self.flightsTableView.reloadData()
                self.loadingViewDissapearBasicAnimation()
            }
        }
    }
    
    // MARK: Animations
    // Loading screen appear animation
    func loadingViewAppearBasicAnimation() {
        self.navigationController?.navigationBar.isHidden = true

        let backgroundAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAlphaAnimation.fromValue = 0
        backgroundAlphaAnimation.toValue = 1
        
        let groupForBackground = CAAnimationGroup()
        groupForBackground.animations = [backgroundAlphaAnimation]
        
        groupForBackground.duration = 1
        groupForBackground.isRemovedOnCompletion = false
        groupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(groupForBackground, forKey: "background animation")
        
        let loadingImageAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        loadingImageAlphaAnimation.fromValue = 0
        loadingImageAlphaAnimation.toValue = 1
        
        let groupForImage = CAAnimationGroup()
        groupForImage.animations = [loadingImageAlphaAnimation]
        
        groupForImage.duration = 1
        groupForImage.isRemovedOnCompletion = false
        groupForImage.fillMode = .forwards
        
        loadingimage.layer.add(groupForImage, forKey: "loading image animation")
    }
    
    // Loading screen disappear animation
    func loadingViewDissapearBasicAnimation() {
        let backgroundAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAlphaAnimation.fromValue = 1
        backgroundAlphaAnimation.toValue = 0
        
        let groupForBackground = CAAnimationGroup()
        groupForBackground.animations = [backgroundAlphaAnimation]
        
        groupForBackground.beginTime = CACurrentMediaTime() + 1.25
        groupForBackground.duration = 0
        groupForBackground.isRemovedOnCompletion = false
        groupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(groupForBackground, forKey: "background animation")
        
        let loadingImageAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        loadingImageAlphaAnimation.fromValue = 1
        loadingImageAlphaAnimation.toValue = 0
        
        let groupForImage = CAAnimationGroup()
        groupForImage.animations = [loadingImageAlphaAnimation]
        
        groupForImage.beginTime = CACurrentMediaTime() + 1.25
        groupForImage.duration = 0
        groupForImage.isRemovedOnCompletion = false
        groupForImage.fillMode = .forwards
        
        loadingimage.layer.add(groupForImage, forKey: "loading image animation")
    }
}

// MARK: - Extensions
extension FlightsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.networkService.flightsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = flightsTableView.dequeueReusableCell(withIdentifier: String(describing: FlightsTableViewCell.self), for: indexPath) as! FlightsTableViewCell
        
        let flight = viewModel.networkService.flightsList[indexPath.section]
        cell.flightFromParent = flight
        cell.flightsDataPublisherFacade = viewModel.networkService.flightsDataPublisherFacade
        cell.addFacadeSubscription()
        
        let currentFlightLikeStatus = viewModel.networkService.flightsDataPublisherFacade.checkLikeStatus(forFlight: flight.searchToken)
        cell.changeButtonColor(likeStatus: currentFlightLikeStatus)
        
        return cell
    }
}

extension FlightsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = view.backgroundColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        flightsTableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.onTapShowFlightDetails(viewModel.networkService.flightsList[indexPath.section].searchToken)
    }
}
