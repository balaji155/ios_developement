//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 20/08/25.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    let followerImageView = GFUIImage(frame: .zero)
    let followerNameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        followerNameLabel.text = follower.login
        followerImageView.downloadImage(from: follower.avatarUrl)
    }
    
    func configure(){
        addSubview(followerImageView)
        addSubview(followerNameLabel)
        
        NSLayoutConstraint.activate([
            followerImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            followerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            followerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            followerImageView.heightAnchor.constraint(equalTo: followerImageView.widthAnchor),
            
            followerNameLabel.topAnchor.constraint(equalTo: followerImageView.bottomAnchor, constant: 12),
            followerNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            followerNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            followerNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
