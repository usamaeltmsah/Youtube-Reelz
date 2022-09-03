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
    private var playlistVM = PlaylistViewModel()
    
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
        youtubePlayerView.delegate = self
    }
    
    private func configureCollectionView() {
        reelzCollectionView.delegate = self
        reelzCollectionView.dataSource = self
        
        reelzCollectionView.register(R.nib.reelsCollectionViewCell)
    }
    
    private func loadPlaylistItems(with parameters: PlaylistParams) {
        PlaylistDataService.shared.getPlaylist(parameters: PlaylistParams.getParams(from: parameters)) { playListData in
            guard let playlistItems = playListData?.items else {
                return
            }
                        
            self.loadDataFromPlaylistItems(playlistItems)
        }
    }
    
    private func loadDataFromPlaylistItems(_ playlistItems: [PlaylistItem]) {
        for item in playlistItems {
            loadVideoItems(with: (item.contentDetails?.videoID)!)
        }
        
        Loader.dismissLoading()
    }
    
    private func loadVideoItems(with id: String) {
        VideoDataService.shared.getVideo(parameters: VideoParams.getParams(from: VideoParams(id: id))) { videoData in
            guard let videoData = videoData else { return }
            
            self.playlistVM.addNewVideo(videoData)
            
            DispatchQueue.main.async {
                self.reelzCollectionView.reloadData()
            }
        }
    }
}

// MARK : - UICollectionViewDelegate
extension YoutubeReelsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoVM = playlistVM.videoAtIndex(indexPath.item)
        if let videoId = videoVM.id {
            Loader.showLoading(youtubePlayerView)
            self.youtubePlayerView.load(withVideoId: videoId)
        }
    }
}

// MARK : - UICollectionViewDataSource
extension YoutubeReelsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        playlistVM.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.reelsCollectionViewCell, for: indexPath)!
        
        let video = playlistVM.videoAtIndex(indexPath.item)
        
        if let imgUrl = video.imgUrl {
            cell.configure(imgUrl: imgUrl)
        }
        
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
