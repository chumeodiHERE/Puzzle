//
//  ViewController.swift
//  Puzzle
//
//  Created by Gia Huy on 02/11/2022.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    var timerValue: Timer = Timer()
    var countdown: Int = 10
    
    private let loadingIcon: LottieAnimationView = {
        var loadingIcon: LottieAnimationView = LottieAnimationView()
        loadingIcon = .init(name: "loading")
        loadingIcon.loopMode = .loop
        loadingIcon.animationSpeed = 0.75
        loadingIcon.translatesAutoresizingMaskIntoConstraints = false
        return loadingIcon
    }()
    
    private let appIcon: UIImageView = {
        let appIcon: UIImageView = UIImageView()
        appIcon.image = UIImage(named: "appIconImage")
        appIcon.contentMode = .scaleAspectFill
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        return appIcon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loadingIcon)
        loadingIcon.play()
        
        view.addSubview(appIcon)
        
        //Function that implements autoLayout for objects in View
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timerToMoveToMenuScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func addConstraints () {
        
        //[CREATE ARRAY OF CONSTRAINTS]
        var conStraints = [NSLayoutConstraint]()
        
        //[APPEND THE CONSTRAINTS OF OBJECTS TO ARRAY]
        
        //Loading Icon
        conStraints.append(loadingIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(loadingIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120))
        conStraints.append(loadingIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5))
        conStraints.append(loadingIcon.heightAnchor.constraint(equalTo: loadingIcon.widthAnchor, multiplier: 1))
        
        //App Icon
        conStraints.append(appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(appIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50))
        conStraints.append(appIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4))
        conStraints.append(appIcon.heightAnchor.constraint(equalTo: appIcon.widthAnchor, multiplier: 1))
        
        //[ACTIVE CONSTRAINTS]
        NSLayoutConstraint.activate(conStraints)
    }
    
    func timerToMoveToMenuScreen() {
        timerValue = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown() {
        countdown -= 1
        if ( countdown == 0) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MenuScreen") as! MenuViewController
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

