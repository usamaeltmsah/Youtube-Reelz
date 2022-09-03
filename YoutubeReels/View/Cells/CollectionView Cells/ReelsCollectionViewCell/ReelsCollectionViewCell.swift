//
//  ReelsCollectionViewCell.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 30/07/2022.
//

import UIKit
import SDWebImage

class ReelsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(imgUrl: String?) {
        if let imgUrlString = imgUrl {
            loadImage(from: imgUrlString)
        }
    }
    
    private func loadImage(from url: String) {
        guard let imgUrl = URL(string: url) else {
            return
        }
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        imageView.sd_setImage(with: imgUrl, placeholderImage: R.image.image())
    }
}
