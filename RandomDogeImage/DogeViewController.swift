//
//  ViewController.swift
//  RandomDogeImage
//
//  Created by Александр Пронин on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dogeImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let link = "https://random.dog/woof.json"
    
    override func viewDidLoad() {
        
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
                let dogeImage = try JSONDecoder().decode(DogeImage.self, from: data)
                
                guard let url = URL(string: dogeImage.url) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                
                DispatchQueue.main.async {
                    self.dogeImageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


