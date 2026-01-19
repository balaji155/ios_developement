//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 08/09/25.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let imageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    func configure() {
        addSubview(messageLabel)
        addSubview(imageView)
        
        messageLabel.textColor = .secondaryLabel
        messageLabel.numberOfLines = 3
        imageView.image = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -130),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 220),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 300)
            
        ])
    }
    
}
