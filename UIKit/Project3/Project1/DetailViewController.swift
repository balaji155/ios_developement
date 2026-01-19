//
//  DetailViewController.swift
//  Project1
//
//  Created by balaji.papisetty on 11/10/25.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var titleText: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleText
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(haveShareTapped))
        
        if let imageName = selectedImage {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func haveShareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No Image to Share")
            return
        }
        
        let vc = UIActivityViewController(activityItems: ["Check out this amazing app! Download it here: https://apps.apple.com/app/idYOUR_APP_ID",image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
