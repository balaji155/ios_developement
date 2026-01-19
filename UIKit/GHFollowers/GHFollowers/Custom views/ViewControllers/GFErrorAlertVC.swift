//
//  GFErrorAlertVC.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 18/08/25.
//

import UIKit

class GFErrorAlertVC: UIViewController {
    
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFMessageLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    let alertView = UIView()
    
    var alertTitle: String?
    var message: String?
    var buttonText: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonText: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonText = buttonText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureAlertUI()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
    }
    
    func configureAlertUI(){
        view.addSubview(alertView)
        
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.backgroundColor = .systemBackground
        alertView.layer.cornerRadius = 16
        alertView.layer.borderWidth = 2
        alertView.layer.borderColor = UIColor.white.cgColor
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            alertView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
    }
    
    func configureTitleLabel(){
        alertView.addSubview(titleLabel)
        
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding),
        ])
    }
    
    func configureButton(){
        alertView.addSubview(actionButton)
        
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding),
            actionButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel(){
        alertView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo:actionButton.topAnchor, constant: -8),
        ])
    }
    
   
    

}
