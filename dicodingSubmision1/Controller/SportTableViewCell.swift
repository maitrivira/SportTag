//
//  SportTableViewCell.swift
//  dicodingSubmision1
//
//  Created by Maitri Vira on 27/05/21.
//

import UIKit
import SkeletonView

class SportTableViewCell: UITableViewCell {

    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportTitleLabel: UILabel!
    @IBOutlet weak var sportDescLabel: UILabel!
    
    private var imgString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startLoading()
    }
    
    func startLoading(){
        sportImageView.layer.cornerRadius = 5
        [sportImageView, sportTitleLabel, sportDescLabel].forEach{ $0?.showAnimatedGradientSkeleton(transition: .crossDissolve(0.25))}
    }

    func stopLoading(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            [self.sportImageView, self.sportTitleLabel, self.sportDescLabel].forEach{ $0?.hideSkeleton()}
        }
    }
    
    func setCellWithValuesOf(_ sport:Sport){
        updateUI(title: sport.sport, desc: sport.sportDescription, image: sport.sportThumb)
    }
    
    private func updateUI(title: String?, desc: String?, image: String?){
        self.sportTitleLabel.text = title
        self.sportDescLabel.text = desc
        
        imgString = image ?? ""
        
        guard let imgURL = URL(string: imgString) else{
            self.sportImageView.image = UIImage(systemName: "photo")
            return
        }
        
        self.sportImageView.image = nil
        
        getImageData(url: imgURL)
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
                    self.sportImageView.image = image
                }
            }
        }.resume()
    }
    
}
