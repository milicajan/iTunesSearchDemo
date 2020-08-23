//
//  SearchSongResultTableViewCell.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 22/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit
import Kingfisher

struct SearchSongResultTableViewCellKeys {
    static let searchSongResultIdentifier = "searchSongResultTableViewCell"
}

class SearchSongResultTableViewCell: UITableViewCell {
    
    private let artistImageView: UIImageView = UIImageView()
    private let trackNameLabel: UILabel = UILabel()
    private let artistNameLabel: UILabel = UILabel()
    
    private let nothingFoundLabel: UILabel = UILabel()
    
    var nothingFound: Bool = false {
        didSet {
            nothingFoundLabel.isHidden = !nothingFound
            artistNameLabel.isHidden = nothingFound
            trackNameLabel.isHidden = nothingFound
            artistImageView.isHidden = nothingFound
        }
    }
    
    var trackNameText: String = "" {
        didSet {
            trackNameLabel.text = trackNameText
        }
    }
    
    var artistNameText: String = "" {
        didSet {
            artistNameLabel.text = artistNameText
        }
    }
    
    var trackArtworkURL: String = "" {
        didSet {
            let imageURL = URL(string: trackArtworkURL)
            artistImageView.kf.indicatorType = .activity
            artistImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.5))])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: SearchSongResultTableViewCellKeys.searchSongResultIdentifier)
        
        accessoryType = .none
        self.selectionStyle = .none
        
        addArtistImageView()
        addTrackNameLabel()
        addArtistNameLabel()
        
        addNothingFoundLabel()
        
        setupConstraints()
    }
    
    private func addArtistImageView() {
        
        addSubview(artistImageView)
    }
    
    private func addTrackNameLabel() {
        trackNameLabel.textAlignment = .left
        trackNameLabel.textColor = .black
        trackNameLabel.font = .systemFont(ofSize: FontSizes.title20)
        trackNameLabel.numberOfLines = 0
        
        addSubview(trackNameLabel)
    }
    
    private func addArtistNameLabel() {
        artistNameLabel.textAlignment = .left
        artistNameLabel.textColor = UIColor.gray
        artistNameLabel.font = .systemFont(ofSize: FontSizes.title17)
        artistNameLabel.numberOfLines = 0
        
        addSubview(artistNameLabel)
    }
    
    private func addNothingFoundLabel() {
        nothingFoundLabel.textAlignment = .left
        nothingFoundLabel.textColor = UIColor.gray
        nothingFoundLabel.font = .systemFont(ofSize: FontSizes.title17)
        nothingFoundLabel.text = nothingFoundLocalizedString
        
        addSubview(nothingFoundLabel)
    }
    
    private func setupConstraints() {
        artistImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(Margins.small10)
            make.centerY.equalToSuperview()
            make.height.equalTo(Sizes.albumImageViewSize.height)
            make.width.equalTo(Sizes.albumImageViewSize.width)
        }
        
        trackNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(artistImageView.snp.right).offset(Margins.small10)
            make.right.equalToSuperview().offset(-Margins.small10)
            make.top.equalTo(artistImageView.snp.top)
        }
        
        artistNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(artistImageView.snp.right).offset(Margins.small10)
            make.right.equalToSuperview().offset(-Margins.small10)
            make.top.equalTo(trackNameLabel.snp.bottom).offset(Margins.small10)
            make.bottom.equalToSuperview().offset(-Margins.small10)
        }
        
        nothingFoundLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension SearchSongResultTableViewCell {
    var nothingFoundLocalizedString: String {
        return Bundle.main.localizedString(forKey: "nothingFoundLocalizedString", value: "Nothing found", table: nil)
    }
}
