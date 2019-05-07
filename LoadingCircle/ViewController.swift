//
//  ViewController.swift
//  LoadingCircle
//
//  Created by Daniel Hjärtström on 2018-11-02.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer!
    var completion: CGFloat = 0.0
    
    private lazy var loadingbar: LoadingBar = {
        let temp = LoadingBar()
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        temp.widthAnchor.constraint(equalTo: temp.heightAnchor).isActive = true
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = rgb(48, green: 48, blue: 48)
        loadingbar.isHidden = false
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            if self.completion < 100 {
                self.completion += 1.0
                self.updateCircle()
            } else {
                self.timer.invalidate()
            }
        })
    }
    
    private func updateCircle() {
        loadingbar.completion = completion
    }
    
}

