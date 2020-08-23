//
//  SongsListViewController.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 22/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
import MBProgressHUD

struct SongsListViewControllerKeys {
    static let searchSongResultIdentifier = "searchSongResultTableViewCell"
}

class SongsListViewController: UIViewController {
    
    private let searchBar: UISearchBar = UISearchBar()
    private let songsListTableView: UITableView = UITableView()
    
    private var searchResults: [Song] = []
    private var hasSearched = false
    private var progressHud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        addSongsListTableView()
        
        setupConstraints()
    }
    
    private func addSearchBar() {
        searchBar.backgroundColor = UIColor.white
        searchBar.becomeFirstResponder()
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = searchBarPlaceholderTextLocalizedString
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func addSongsListTableView() {
        songsListTableView.dataSource = self
        songsListTableView.delegate = self
        songsListTableView.backgroundColor = .white
        songsListTableView.separatorStyle = .singleLine
        songsListTableView.showsVerticalScrollIndicator = false
        songsListTableView.rowHeight = UITableView.automaticDimension
        songsListTableView.estimatedRowHeight = 70.0
        songsListTableView.translatesAutoresizingMaskIntoConstraints = false
        songsListTableView.register(SearchSongResultTableViewCell.self, forCellReuseIdentifier: SongsListViewControllerKeys.searchSongResultIdentifier)
        songsListTableView.layoutMargins = UIEdgeInsets.zero
        songsListTableView.separatorInset = UIEdgeInsets.zero
        
        view.addSubview(songsListTableView)
    }
    
    private func setupConstraints() {
        songsListTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.left.right.equalToSuperview()
        }
    }
}

extension SongsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let songName = searchBar.text else { return }
        searchSongs(for: songName)
    }
}

extension SongsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hasSearched {
            return searchResults.count == 0 ? 1 : searchResults.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songsListTableView.dequeueReusableCell(withIdentifier: SongsListViewControllerKeys.searchSongResultIdentifier, for: indexPath)
        
        guard let searchSongResultTableViewCell = cell as? SearchSongResultTableViewCell else {
            return cell
        }
        
        if searchResults.count == 0 {
            searchSongResultTableViewCell.nothingFound = true
        } else {
            searchSongResultTableViewCell.nothingFound = false
            searchSongResultTableViewCell.trackNameText = searchResults[indexPath.row].trackName
            searchSongResultTableViewCell.artistNameText = searchResults[indexPath.row].artistName
            searchSongResultTableViewCell.trackArtworkURL = searchResults[indexPath.row].artworkImg
        }
        
        return searchSongResultTableViewCell
    }
}

extension SongsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard searchResults.count != 0 else {
            return
        }
        DispatchQueue.main.async {
            let songDetailsVC = SongPreviewViewController()
            songDetailsVC.song = self.searchResults[indexPath.row]
            songDetailsVC.modalPresentationStyle = .overCurrentContext
            self.present(songDetailsVC, animated: true, completion: nil)
        }
    }
}

extension SongsListViewController {
    func searchSongs(for name: String) {
        self.presentLoader()
        
        dataAccess.searchSongs(songName: name, successHandler: { (songs) in
            self.dismissLoader()
            
            self.searchResults = songs?.all ?? []
            self.hasSearched = true
            
            DispatchQueue.main.async {
                self.songsListTableView.reloadData()
            }
        }) { (message) in
            self.dismissLoader()
            
            self.searchResults = []
            self.hasSearched = false
            
            DispatchQueue.main.async {
                self.songsListTableView.reloadData()
                self.showError(message: self.errorMsgLocalizedString + "\n\(message ?? "")")
            }
        }
    }
}

extension SongsListViewController {
    
    func presentLoader() {
        DispatchQueue.main.async {
            if self.progressHud == nil {
                self.progressHud = MBProgressHUD.showAdded(to: self.view, animated: true)
                if let hud = self.progressHud {
                    hud.minSize = CGSize(width: 100, height: 100)
                    hud.bezelView.backgroundColor = .white
                    hud.bezelView.color = .white
                    hud.bezelView.style = .solidColor
                    hud.contentColor = UIColor.gray
                    hud.label.text = self.loadingMessageTitleLocalizedString
                    hud.label.textColor = UIColor.gray
                    hud.detailsLabel.text = self.waitMessageTitleLocalizedString
                    hud.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.progressHud = nil
        }
    }
    
    func showError(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: errorLocalizedString, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okLocalizedString, style: .cancel, handler: { _ in
            completion?()
        }))
        
        present(alert, animated: true, completion: completion)
    }
}

extension SongsListViewController {
    var searchBarPlaceholderTextLocalizedString: String {
        return Bundle.main.localizedString(forKey: "searchBarPlaceholderTextLocalizedString", value: "Search ...", table: nil)
    }
    
    var okLocalizedString: String {
        return Bundle.main.localizedString(forKey: "okayLocalizedString", value: "OK", table: nil)
    }
    
    var loadingMessageTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "loadingMessageLocalizedString", value: "Loading...", table: nil)
    }
    
    var waitMessageTitleLocalizedString: String {
        return Bundle.main.localizedString(forKey: "waitMessageLocalizedString", value: "Please Wait", table: nil)
    }
    
    var errorLocalizedString: String {
        return Bundle.main.localizedString(forKey: "errorMessageLocalizedString", value: "Error", table: nil)
    }
    
    var errorMsgLocalizedString: String {
        return Bundle.main.localizedString(forKey: "errorMsgLocalizedString", value: "Something went wrong. Please try again!", table: nil)
    }
}

