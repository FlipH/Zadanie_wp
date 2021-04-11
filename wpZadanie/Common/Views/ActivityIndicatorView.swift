//
//  ActivityIndicatorView.swift
//  wpZadanie
//
//  Created by Filip Harasim on 08/03/2020.
//  Copyright © 2020 Filip Harasim. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {

    let activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .gray)
        av.startAnimating()
        av.translatesAutoresizingMaskIntoConstraints = false
        return av
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor(named: "background")

        self.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
