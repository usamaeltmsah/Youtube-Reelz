//
//  ViewController.swift
//  Youtube-Reels
//
//  Created by Usama Fouad on 29/07/2022.
//

import UIKit
import YoutubePlayer_in_WKWebView

class YoutubeReelsViewController: UIViewController {
    
    // MARK : - IBOutlets
    @IBOutlet weak var reelzCollectionView: UICollectionView!
    @IBOutlet weak var youtubePlayerView: WKYTPlayerView!
    
    // MARK : - Private Variables
    private let playlistVM = PlaylistViewModel()
    
    private let videoVM = VideoViewModel()
    
    private var playlistItems: [PlaylistItem]? {
        didSet {
            for item in playlistItems! {
                loadVideoItems(with: (item.contentDetails?.videoID)!)
            }
            
            Loader.dismissLoading()
        }
    }
    
    private var videos: [YoutubeVideo] = []
    
    
    // MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK : - Private Methods
    
    private func configureUI() {
        Loader.showLoading(view)
        configureCollectionView()
        loadPlaylistItems(with: PlaylistParams())
        configureYoutubePlayer()
    }
    
    private func configureYoutubePlayer() {
//        youtubePlayerView.load(withPlaylistId: K.playlistId)
        youtubePlayerView.delegate = self
    }
    
    private func configureCollectionView() {
        reelzCollectionView.delegate = self
        reelzCollectionView.dataSource = self
        
        reelzCollectionView.register(R.nib.reelsCollectionViewCell)
    }
    
    private func loadPlaylistItems(with parameters: PlaylistParams) {
        playlistVM.getPlaylist(parameters: PlaylistParams.getParams(from: parameters)) { [weak self] in
            self?.playlistItems = self?.playlistVM.playlistModel?.items
        }
    }
    
    private func loadVideoItems(with id: String) {
        videoVM.getVideo(parameters: VideoParams.getParams(from: VideoParams(id: id))) { [weak self] in
            self?.videos.append(self?.videoVM.videoModel ?? YoutubeVideo())
            self?.reelzCollectionView.reloadData()
        }
    }
}


// MARK : - UICollectionViewDelegate
extension YoutubeReelsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let video = videos[indexPath.item]
        if let videoId = video.items?.first?.id {
            Loader.showLoading(youtubePlayerView)
            self.youtubePlayerView.load(withVideoId: videoId)
        }
    }
}

// MARK : - UICollectionViewDataSource
extension YoutubeReelsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.reelsCollectionViewCell, for: indexPath)!
        
        let video = videos[indexPath.item]
        
        if let imgUrl = video.items?.first?.snippet?.thumbnails?.thumbnailsDefault?.url {
            cell.configure(imgUrl: imgUrl)
        }
//        cell.configure(video: videos[indexPath.item])
        
        return cell
    }
    
    
}


// MARK : - WKYTPlayerViewDelegate

extension YoutubeReelsViewController: WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        playerView.playVideo()
        Loader.dismissLoading()
    }
}
