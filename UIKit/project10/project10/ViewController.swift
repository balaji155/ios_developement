//
//  ViewController.swift
//  project10
//
//  Created by balaji.papisetty on 24/11/25.
//

import UIKit

class ViewController: UICollectionViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var people: [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(selectImage))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        let person = people[indexPath.item]
        
        cell.nameLabel.text = person.name
        cell.nameLabel.textColor = .black
        let imagePath = getDocumentDirectory().appending(path: person.imageName)
        cell.imageView.image = UIImage(contentsOfFile: imagePath.path)
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.cornerRadius = 8
        cell.layer.cornerRadius = 8
        
        
        return cell
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        let ac = UIAlertController(title: "Rename person or delete", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default){[weak self,weak ac] _ in
            guard let personName = ac?.textFields?[0].text else { return }
            guard !personName.isEmpty else { return }
            person.name = personName
            self?.collectionView.reloadData()
        })
        
//        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "delete", style: .default){
            [weak self] _ in
            self?.people.remove(at: indexPath.item)
            self?.collectionView.reloadData()
        })
        
        present(ac, animated: true)
    }
    
    @objc func selectImage() {
        let pickerController = UIImagePickerController()
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            return
        }
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
        pickerController.delegate = self
        present(pickerController,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageData = info[.editedImage] as? UIImage else {
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let imageJpegData = imageData.jpegData(compressionQuality: 0.8) {
            try? imageJpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Un-Known", imageName: imageName)
        people.append(person)
        collectionView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }


}

