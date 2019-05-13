//
//  MusicTrackCell.swift
//  App Store
//
//  Created by hosam on 5/13/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MusicTrackCell: BaseCell {
    
    var musics:Result?  {
        didSet{
            guard let music = musics else { return  }
            nameLabel.text = music.trackName
            imageView.sd_setImage(with: URL(string: music.artworkUrl100))
            subtitleLabel.text = "\(music.artistName ?? "") • \(music.collectionName ?? "")"
        }
    }
    
    let imageView:UIImageView = {
        let im = UIImageView(cornerRdius: 16)
        im.image = #imageLiteral(resourceName: "garden")
        im.constrainWidth(constant: 80)
        return im
    }()
    let nameLabel = UILabel(string: "Track Name", font: .boldSystemFont(ofSize: 18))
    let subtitleLabel = UILabel(string: "Subtitle Label", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    override func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [nameLabel, subtitleLabel], spacing: 4)
            ], customSpacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
     }
}
