//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 18/08/25.
//

import UIKit

fileprivate var loadingView: UIView!

extension UIViewController {
    func presentAlertVCOnMainThread(alertTitle: String,message: String,buttonText: String){
        DispatchQueue.main.async{
            let alertVC = GFErrorAlertVC(title: alertTitle, message: message, buttonText: buttonText)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
       
    }
    
    func showLoadingView () {
        loadingView = UIView(frame: view.bounds)
        view.addSubview(loadingView)
        loadingView.backgroundColor = .systemBackground
        loadingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            loadingView.alpha = 0.8
        }
        
        let activateIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activateIndicator)
        activateIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activateIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activateIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activateIndicator.startAnimating()
    }
    
    func dissmissLoadingView(){
        DispatchQueue.main.async {
            loadingView.removeFromSuperview()
            loadingView = nil
        }
    }
    
    func showEmptyStateView(with message: String,in view: UIView){
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
