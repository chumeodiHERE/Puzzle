//
//  HelpViewController.swift
//  Puzzle
//
//  Created by Gia Huy on 10/11/2022.
//

import UIKit

class HelpViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = "HELP"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Helvetica Neue Medium", size: 45)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let backButton: UIButton = {
        let backButton: UIButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private let ruleTextView: UITextView = {
        let ruleTextView: UITextView = UITextView()
        ruleTextView.isEditable = false
        ruleTextView.font = UIFont(name: "Helvetica Neue Regular", size: 17)
        ruleTextView.textAlignment = .justified
        ruleTextView.backgroundColor = .clear
        ruleTextView.text = """
Write something about the rules of the game.
"""
        ruleTextView.translatesAutoresizingMaskIntoConstraints = false
        return ruleTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backButton.addTarget(self, action: #selector(goBackMenuScreen), for: .touchUpInside)
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(ruleTextView)
        
        //Function that implements autoLayout for objects in View
        addConstraints()
    }
    
    private func addConstraints ()
    {
        //[CREATE ARRAY OF CONSTRAINTS]
        var conStraints = [NSLayoutConstraint]()
        
        //[APPEND THE CONSTRAINTS OF OBJECTS TO ARRAY]
        
        //Title
        conStraints.append(titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100))

        //Back button
        conStraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10))
        
        //Rule TextView
        conStraints.append(ruleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(ruleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        conStraints.append(ruleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20))
        conStraints.append(ruleTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50))
        
        
        //[ACTIVE CONSTRAINTS]
        NSLayoutConstraint.activate(conStraints)
    }
    
    @objc private func goBackMenuScreen(sender: UIButton)
    {
        self.dismiss(animated: true)
    }
}
