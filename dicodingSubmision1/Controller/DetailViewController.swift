//
//  DetailViewController.swift
//  dicodingSubmision1
//
//  Created by Maitri Vira on 27/05/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var imgString: String = ""

    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var detailDescLabel: UILabel!
    
    var sport: Sport?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.largeTitleDisplayMode = .never
        
        startLoading()
        updateUI()
    }
    
    private func startLoading(){
        [detailImgView, detailDescLabel].forEach{ $0?.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))}
    }

    private func stopLoading(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            [self.detailImgView, self.detailDescLabel].forEach{ $0?.hideSkeleton()}
        }
    }
    
    private func updateUI(){
        if let result = sport {
            stopLoading()
                    
            detailDescLabel.text = result.sportDescription
            navigationItem.title = result.sport
            
            imgString = result.sportThumb ?? ""
            guard let imgURL = URL(string: imgString) else{
                self.detailImgView.image = UIImage(systemName: "photo")
                return
            }
            self.detailImgView.image = nil
            getImageData(url: imgURL)
        }else{
            startLoading()
        }
    }
    
    private func getImageData(url: URL){
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            if let error = error{
                print("error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else{
                print("Empty")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.detailImgView.image = image
                }
            }
        }.resume()
    }
}
