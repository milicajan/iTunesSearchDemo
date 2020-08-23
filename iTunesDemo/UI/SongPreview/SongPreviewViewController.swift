//
//  SongPreviewViewController.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 22/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit

class SongPreviewViewController: UIViewController {
    
    private let containerView: UIView = UIView()
    private let albumArtworkImageView: UIImageView = UIImageView()
    private let artistNameLabel: UILabel = UILabel()
    private let songNameLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton()
    
    var song: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.75)
        
        addContainerView()
        
        addAlbumArtworkImageView()
        addSongNameLabel()
        addArtistNameLabel()
        
        addCloseButton()
        
        setupConstraints()
    }
    
    private func addContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = CornerRadius.small20
        
        view.addSubview(containerView)
    }
    
    private func addAlbumArtworkImageView() {
        if let artworkImg = song?.artworkImg {
            let imageURL = URL(string: artworkImg)
            albumArtworkImageView.kf.indicatorType = .activity
            albumArtworkImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.5))])
        }
        
        containerView.addSubview(albumArtworkImageView)
    }
    
    private func addSongNameLabel() {
        songNameLabel.textAlignment = .center
        songNameLabel.textColor = .black
        songNameLabel.font = .systemFont(ofSize: FontSizes.title20)
        songNameLabel.text = song?.trackName
        songNameLabel.lineBreakMode = .byWordWrapping
        songNameLabel.numberOfLines = 2
        
        containerView.addSubview(songNameLabel)
    }
    
    private func addArtistNameLabel() {
        artistNameLabel.textAlignment = .center
        artistNameLabel.textColor = .gray
        artistNameLabel.font = .systemFont(ofSize: FontSizes.title17)
        artistNameLabel.text = song?.artistName
        artistNameLabel.lineBreakMode = .byWordWrapping
        artistNameLabel.numberOfLines = 2
        
        containerView.addSubview(artistNameLabel)
    }
    
    private func addCloseButton() {
        closeButton.backgroundColor = .white
        closeButton.setTitle(closeButtonTitleLocalizedString, for: .normal)
        closeButton.setTitleColor(.gray, for: .normal)
        closeButton.layer.cornerRadius = CornerRadius.small10
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Margins.small20)
            make.right.equalToSuperview().offset(-Margins.small20)
            make.height.equalTo(Sizes.containerView.height)
        }
        
        albumArtworkImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Margins.small20)
            make.width.height.equalTo(Sizes.containerView.height / 2)
        }
        
        songNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(albumArtworkImageView.snp.bottom).offset(Margins.small10)
            make.left.equalToSuperview().offset(Margins.small20)
            make.right.equalToSuperview().offset(-Margins.small20)
        }
        
        artistNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(songNameLabel.snp.bottom).offset(Margins.small10)
            make.left.equalToSuperview().offset(Margins.small20)
            make.right.equalToSuperview().offset(-Margins.small20)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom).offset(Margins.small20)
            make.width.equalTo(Sizes.containerView.height / 2)
            make.centerX.equalTo(containerView.snp.centerX)
        }
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SongPreviewViewController {
    var closeButtonTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "closeButtonTitleLocalizedString", value: "Close", table: nil)
    }
}
