//
//  ActivityIndicatorUIView.swift
//  chocoed
//
//  Created by barkha sikka on 08/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class ActivityIndicatorUIView: UIView {
    var activityUIView: UIView!
    var myActivityIndicator: UIActivityIndicatorView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityUIView = UIView(frame: frame)
        activityUIView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        self.addSubview(activityUIView)
        activityUIView.translatesAutoresizingMaskIntoConstraints = false
        activityUIView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        activityUIView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        activityUIView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        activityUIView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        myActivityIndicator.center = self.center
        self.addSubview(myActivityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startAnimation() {
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
    }

    func stopAnimation() {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.hidesWhenStopped = true
    }
}
