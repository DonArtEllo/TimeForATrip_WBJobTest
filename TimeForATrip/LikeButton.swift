//
//  LikeButton.swift
//  TimeForATrip
//
//  Created by Артем on 01.06.2022.
//

import UIKit

/// Custom round Like button
final class LikeButton: UIView {

    private let likeImageView: UIImageView = {
        let likeImageView = UIImageView()
        likeImageView.contentMode = .scaleAspectFit
        likeImageView.tintColor = .systemRed
        likeImageView.image = UIImage(systemName: "heart")
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        return likeImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemRed.cgColor
        layer.cornerRadius = 28
        backgroundColor = .white
        
        addSubview(likeImageView)
        
        let likeConstraints = [
            likeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeImageView.heightAnchor.constraint(equalToConstant: 32),
            likeImageView.widthAnchor.constraint(equalToConstant: 32)
        ]
        
        NSLayoutConstraint.activate(likeConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func toggleLike(newLikeStatus: Bool) {
        if newLikeStatus {
            likeImageView.tintColor = .white
            self.backgroundColor = .systemRed
        } else {
            likeImageView.tintColor = .systemRed
            self.backgroundColor = .white
        }
    }

}
