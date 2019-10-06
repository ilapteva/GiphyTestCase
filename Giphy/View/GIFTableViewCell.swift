//
//  GIFTableViewCell.swift
//  Giphy
//
//  Created by Ира on 04/10/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import UIKit
import TinyConstraints
import Gifu

class GIFViewCell: UITableViewCell {
    
    var loadingGif: GIFImageView = {
        let view = GIFImageView()

        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        

        return view
    }()
    
    
    
//    var loadingGif: UIImageView = {
//
//        var imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(loadingGif)
                
                
                loadingGif.width(300)
                loadingGif.height(300)
                loadingGif.centerXToSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
