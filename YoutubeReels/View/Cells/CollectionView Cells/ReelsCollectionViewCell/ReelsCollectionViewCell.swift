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
    
//    func configure(video: YoutubeVideo?) {
//        if let imgUrlString = video?.items?.first?.snippet?.thumbnails?.thumbnailsDefault?.url {
//            loadImage(from: imgUrlString)
//        }
//    }
    
    private func loadImage(from url: String) {
        guard let imgUrl = URL(string: url) else {
            return
        }
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "image"), options: SDWebImageOptions(rawValue: 0), completed: { (img, err, cacheType, imgURL) in
                // code
            })
        }
}
