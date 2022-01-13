//
//  CatViewController.swift
//  RandomDogeImage
//
//  Created by Александр Пронин on 13.01.2022.
//

import UIKit

class CatViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var catImageView: UIImageView!
    
    let link = "https://aws.random.cat/meow"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.style = .large
        
    }
    
    @IBAction func generateImageButton(_ sender: UIButton) {
        
        activityIndicator.startAnimating()
        
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data else { return }
            
            do {
                let catImage = try JSONDecoder().decode(CatImage.self, from: data)
                
                guard let url = URL(string: catImage.file) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                
                DispatchQueue.main.async {
                    self.catImageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
