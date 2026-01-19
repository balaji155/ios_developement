//
//  ViewController.swift
//  project6b
//
//  Created by balaji.papisetty on 28/10/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints  = false
        label1.text = "THESE"
        label1.backgroundColor = .red
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints  = false
        label2.text = "ARE"
        label2.backgroundColor = .cyan
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints  = false
        label3.text = "SOME"
        label3.backgroundColor = .green
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints  = false
        label4.text = "AWESOME"
        label4.backgroundColor = .yellow
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints  = false
        label5.text = "LABELS"
        label5.backgroundColor = .orange
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        NSLayoutConstraint.activate([
//            label1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            label1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            label1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            label1.bottomAnchor.constraint(equalTo: label1.bottomAnchor, constant: -20),
//            
//            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20)
//        ])
//        
//        var labelsDictoniries: [String: UILabel] = [:]
//        labelsDictoniries["label1"] = label1
//        labelsDictoniries["label2"] = label2
//        labelsDictoniries["label3"] = label3
//        labelsDictoniries["label4"] = label4
//        labelsDictoniries["label5"] = label5
//        
//        for label in labelsDictoniries.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: labelsDictoniries))
//        }
//        let metrics = ["labelHeight": 88]
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: labelsDictoniries))
    
        var previousLabel: UILabel?
        for label in [label1,label2,label3,label4,label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            if let prevLabel = previousLabel {
                label.topAnchor.constraint(equalTo: prevLabel.bottomAnchor, constant: 10).isActive = true
            }else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            previousLabel = label
        }
        
    }


}

