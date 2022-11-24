//
//  CopyrightViewController.swift
//  Puzzle
//
//  Created by Gia Huy on 05/11/2022.
//

import UIKit

class CopyrightViewController: UIViewController {
    
    static let screenSize: CGRect = UIScreen.main.bounds
    let Width: CGFloat = screenSize.width
    let Height: CGFloat = screenSize.height

    private let infoOfStudentTextView: UITextView = {
        let infoOfStudentTextView: UITextView = UITextView()
        infoOfStudentTextView.isEditable = false
        infoOfStudentTextView.font = UIFont(name: "Helvetica Neue Medium", size: 15)
        infoOfStudentTextView.textAlignment = .justified
        infoOfStudentTextView.backgroundColor = .clear
        infoOfStudentTextView.text = """
Information about the app:

Developer:

Student ID:

Category:

Language:
"""
        infoOfStudentTextView.translatesAutoresizingMaskIntoConstraints = false
        return infoOfStudentTextView
    }()
    
    
    private let CopyrighTextView: UITextView = {
        let CopyrighTextView: UITextView = UITextView()
        CopyrighTextView.isEditable = false
        CopyrighTextView.font = UIFont(name: "Helvetica Neue Medium", size: 15)
        CopyrighTextView.textAlignment = .center
        CopyrighTextView.backgroundColor = .clear
        CopyrighTextView.text = """
Copyright © (Developer name),
Copyright 2022 University of ...
All rights reserved

Disclaimer: This app and all materials in the app is only used for educational purpose.
"""
        CopyrighTextView.translatesAutoresizingMaskIntoConstraints = false
        return CopyrighTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Copyright/About"
        
        view.addSubview(infoOfStudentTextView)
        view.addSubview(CopyrighTextView)
        
        //Function that implements autoLayout for objects in View
        addConstraints()
    }
    
    
    private func addConstraints () {
        
        //[CREATE ARRAY OF CONSTRAINTS]
        var conStraints = [NSLayoutConstraint]()
        
        //Info Of Student TextView
        conStraints.append(infoOfStudentTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: Width/2))
        conStraints.append(infoOfStudentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(infoOfStudentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        conStraints.append(infoOfStudentTextView.heightAnchor.constraint(equalTo: infoOfStudentTextView.widthAnchor, multiplier: 0.7))
        
        //Copyright TextView
        conStraints.append(CopyrighTextView.topAnchor.constraint(equalTo: infoOfStudentTextView.bottomAnchor, constant: 5))
        conStraints.append(CopyrighTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(CopyrighTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        conStraints.append(CopyrighTextView.heightAnchor.constraint(equalTo: CopyrighTextView.widthAnchor, multiplier: 1/2))
        
        //[ACTIVE CONSTRAINTS]
        NSLayoutConstraint.activate(conStraints)
    }
    
}
