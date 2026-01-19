//
//  SearchVC.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 18/08/25.
//

import UIKit

class SearchVC: UIViewController {
    
    var logoImageView = UIImageView()
    var callToActionBtn = GFButton(backgroundColor: .systemGreen, title: "Get the followers")
    var textFieldView = GFTextField()
    var isUserNameEntered: Bool {
        return !textFieldView.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageView()
        configureTextField()
        configureCallToActionButton()
        createDissmissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDissmissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushToFollowersListVC(){
        guard isUserNameEntered else {
            presentAlertVCOnMainThread(alertTitle: "Empty User Name", message: "Please enter username to get results 😁.", buttonText: "Ok")
            return
        }
        let followersListVC = FollowersListVC()
        followersListVC.userName = textFieldView.text ?? ""
        followersListVC.title = textFieldView.text ?? ""
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    //UI
    func configureImageView(){
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    func configureTextField(){
        view.addSubview(textFieldView)
        textFieldView.delegate = self
        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            textFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textFieldView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton(){
        view.addSubview(callToActionBtn)
        callToActionBtn.addTarget(self, action: #selector(pushToFollowersListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            callToActionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowersListVC()
        return true
    }
}
