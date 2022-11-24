//
//  MenuViewController.swift
//  Puzzle
//
//  Created by Gia Huy on 03/11/2022.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let appIcon: UIImageView = {
        let appIcon: UIImageView = UIImageView()
        appIcon.image = UIImage(named: "appIconImage")
        appIcon.contentMode = .scaleAspectFill
        appIcon.translatesAutoresizingMaskIntoConstraints = false
        return appIcon
    }()
    
    private let nameAppLabel: UILabel = {
        let nameAppLabel: UILabel = UILabel()
        nameAppLabel.text = "Puzzle"
        nameAppLabel.textAlignment = .center
        nameAppLabel.font = UIFont(name: "Helvetica Neue Bold", size: 30)
        nameAppLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameAppLabel
    }()
    
    private let playDailyQuizButton: UIButton = {
        let playDailyQuizButton: UIButton = UIButton()
        playDailyQuizButton.setTitle("Start", for: .normal)
        playDailyQuizButton.setTitleColor(UIColor.white, for: .normal)
        playDailyQuizButton.backgroundColor = UIColor(named: "DarkBrown")
        playDailyQuizButton.translatesAutoresizingMaskIntoConstraints = false
        return playDailyQuizButton
    }()
    
    private let helpButton: UIButton = {
        let helpButton: UIButton = UIButton()
        helpButton.setTitle("Help", for: .normal)
        helpButton.titleLabel?.font = UIFont(name: "Helvetica Neue Bold", size: 20)
        helpButton.setTitleColor(UIColor(named: "DarkBrown"), for: .normal)
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        return helpButton
    }()
    
    private let historyButton: UIButton = {
        let historyButton: UIButton = UIButton()
        historyButton.setTitle("History", for: .normal)
        historyButton.setTitleColor(UIColor.white, for: .normal)
        historyButton.backgroundColor = UIColor(named: "DarkBrown")
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        return historyButton
    }()
    
    private let copyrightButton: UIButton = {
        let copyrightButton: UIButton = UIButton()
        copyrightButton.setTitle("Copyright/About", for: .normal)
        copyrightButton.setTitleColor(UIColor.white, for: .normal)
        copyrightButton.backgroundColor = UIColor(named: "DarkBrown")
        copyrightButton.translatesAutoresizingMaskIntoConstraints = false
        return copyrightButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playDailyQuizButton.addTarget(self, action: #selector(goToPlayDailyQuizScreen), for: .touchUpInside)
        historyButton.addTarget(self, action: #selector(goToHistoryScreen), for: .touchUpInside)
        copyrightButton.addTarget(self, action: #selector(goToCopyrightScreen), for: .touchUpInside)
        helpButton.addTarget(self, action: #selector(gotoHelpScreen), for: .touchUpInside)
        view.addSubview(appIcon)
        view.addSubview(nameAppLabel)
        view.addSubview(playDailyQuizButton)
        view.addSubview(historyButton)
        view.addSubview(copyrightButton)
        view.addSubview(helpButton)
        
        
        //Function that implements autoLayout for objects in View
        addConstraints()
    }
    
    private func addConstraints () {
        
        //[CREATE ARRAY OF CONSTRAINTS]
        var conStraints = [NSLayoutConstraint]()
        
        //[APPEND THE CONSTRAINTS OF OBJECTS TO ARRAY]
        
        //App Icon
        conStraints.append(appIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(appIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100))
        conStraints.append(appIcon.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5))
        conStraints.append(appIcon.heightAnchor.constraint(equalTo: appIcon.widthAnchor, multiplier: 1))
        
        //Label of Name
        conStraints.append(nameAppLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(nameAppLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20))
        conStraints.append(nameAppLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3))
        conStraints.append(nameAppLabel.heightAnchor.constraint(equalTo: nameAppLabel.widthAnchor, multiplier: 1/2))
        
        //Daily Quiz Button
        conStraints.append(playDailyQuizButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(playDailyQuizButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50))
        conStraints.append(playDailyQuizButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45))
        conStraints.append(playDailyQuizButton.heightAnchor.constraint(equalTo: playDailyQuizButton.widthAnchor, multiplier: 1/3))
        
        //History Button
        conStraints.append(historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(historyButton.topAnchor.constraint(equalTo: playDailyQuizButton.bottomAnchor, constant: 20))
        conStraints.append(historyButton.widthAnchor.constraint(equalTo: playDailyQuizButton.widthAnchor, multiplier: 1))
        conStraints.append(historyButton.heightAnchor.constraint(equalTo: historyButton.widthAnchor, multiplier: 1/3))
        
        //Copyright Button
        conStraints.append(copyrightButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(copyrightButton.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 20))
        conStraints.append(copyrightButton.widthAnchor.constraint(equalTo: historyButton.widthAnchor, multiplier: 1))
        conStraints.append(copyrightButton.heightAnchor.constraint(equalTo: copyrightButton.widthAnchor, multiplier: 1/3))
        
        
        //Help Button
        conStraints.append(helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30))
        conStraints.append(helpButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100))
        
        //[ACTIVE CONSTRAINTS]
        NSLayoutConstraint.activate(conStraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func animateButton(_ viewToAnimate:UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    
    //EVENT OF BUTTONS
    @objc fileprivate func goToPlayDailyQuizScreen(sender: UIButton)
    {
        self.animateButton(sender)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DailyQuizScreen") as! DailyQuizViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func goToHistoryScreen(sender: UIButton)
    {
        self.animateButton(sender)
        let vc = storyboard?.instantiateViewController(withIdentifier: "HistoryScreen") as! HistoryViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func goToCopyrightScreen(sender: UIButton)
    {
        self.animateButton(sender)
        let vc = storyboard?.instantiateViewController(withIdentifier: "CopyrightScreen") as! CopyrightViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func gotoHelpScreen(sender: UIButton)
    {
        self.animateButton(sender)
        let vc = HelpViewController()
        present(vc, animated: true)
    }
}
