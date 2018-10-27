//
//  CommonProgressView.swift
//  chocoed
//
//  Created by Tejal on 27/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation


class CommonProgressView : UIView{
    private let progressView : UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(progressView)
        
    }
}
