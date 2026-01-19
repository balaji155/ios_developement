//
//  ViewController.swift
//  Project1
//
//  Created by balaji.papisetty on 11/10/25.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Strom Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            var tempPictures = [String]()
            for item in items {
                if item.hasPrefix("nssl"){
                    tempPictures.append(item)
                }
            }
            guard tempPictures.isEmpty == false else { return }
            tempPictures.sort()
            DispatchQueue.main.async {
                [weak self] in
                self?.pictures = tempPictures
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? ImageCellCollectionViewCell else {
            fatalError("Invalid cell")
        }
        
        let imageName = pictures[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        cell.imageView?.layer.cornerRadius = 8
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView?.layer.borderWidth = 1
        cell.layer.borderWidth = 2
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.item]
            vc.titleText = "\(indexPath.item) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pictures.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "picture", for: indexPath)
//        cell.textLabel?.text = pictures[indexPath.row]
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictures[indexPath.row]
//            vc.titleText = "\(indexPath.row + 1) of \(pictures.count)"
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }


}

