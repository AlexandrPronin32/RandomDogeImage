//
//  FoxViewController.swift
//  RandomDogeImage
//
//  Created by Александр Пронин on 13.01.2022.
//

import UIKit

class FoxViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var foxImageView: UIImageView!
    
    let link = "https://randomfox.ca/floof/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.style = .large
       
    }
    

    @IBAction func generateImageButton(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data , _ , error in
            guard let data = data else { return }
            
            do {
                let foxImage = try JSONDecoder().decode(FoxImage.self, from: data)
                
                guard let url = URL(string: foxImage.image) else {return}
                guard let imageData = try? Data(contentsOf: url) else {return}
                
                DispatchQueue.main.async {
                    self.foxImageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
                }
            }
            catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
