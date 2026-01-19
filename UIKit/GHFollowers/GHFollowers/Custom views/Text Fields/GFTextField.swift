//
//  GFTextField.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 18/08/25.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        font = UIFont.preferredFont(forTextStyle: .title2)
        returnKeyType = .go
        
        placeholder = "Enter User Name"
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
    }

}
