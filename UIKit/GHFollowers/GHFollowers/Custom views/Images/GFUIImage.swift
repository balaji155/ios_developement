//
//  GFUIImage.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 20/08/25.
//

import UIKit

class GFUIImage: UIImageView {
    
    let placeHolderImage: UIImage = UIImage(named: "avatar-placeholder")!
    let cache = NetworkManager.shared.cache
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func downloadImage(from url: String) {
        let cacheKey = NSString(string: url)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
