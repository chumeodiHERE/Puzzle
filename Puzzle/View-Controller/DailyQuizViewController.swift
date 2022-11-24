//
//  DailyQuizViewController.swift
//  Puzzle
//
//  Created by Gia Huy on 03/11/2022.
//

import UIKit
import SDWebImage

class DailyQuizViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let screenSize: CGRect = UIScreen.main.bounds
    let Width: CGFloat = screenSize.width
    let Height: CGFloat = screenSize.height
    var indexOfPic: Int = 0
    var quiz: Quiz = Quiz()
    
    private let QuizImage: UIImageView = {
        let QuizImage: UIImageView = UIImageView()
        QuizImage.contentMode = .scaleAspectFill
        QuizImage.clipsToBounds = true
        QuizImage.translatesAutoresizingMaskIntoConstraints = false
        return QuizImage
    }()
    
    private let resultTextView: UITextView = {
        let resultTextView: UITextView = UITextView()
        resultTextView.isHidden = true
        resultTextView.backgroundColor = .clear
        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        return resultTextView
    }()
    
    private let articleTextView: UITextView = {
        let articleTextView: UITextView = UITextView()
        articleTextView.isHidden = true
        articleTextView.backgroundColor = .clear
        articleTextView.translatesAutoresizingMaskIntoConstraints = false
        return articleTextView
    }()
    
    private let StatusLabel: UILabel = {
        let StatusLabel: UILabel = UILabel()
        StatusLabel.text = ""
        StatusLabel.textColor = .white
        StatusLabel.backgroundColor = UIColor(named: "DarkBrown")
        StatusLabel.isHidden = false
        StatusLabel.textAlignment = .left
        StatusLabel.font = UIFont(name: "Helvetica Neue Medium", size: 20)
        StatusLabel.translatesAutoresizingMaskIntoConstraints = false
        return StatusLabel
    }()
    
    private let NumberOfPicturesLabel: UILabel = {
        let NumberOfPicturesLabel: UILabel = UILabel()
        NumberOfPicturesLabel.text = "1/5"
        NumberOfPicturesLabel.textAlignment = .center
        NumberOfPicturesLabel.font = UIFont(name: "Helvetica Neue Medium", size: 25)
        NumberOfPicturesLabel.translatesAutoresizingMaskIntoConstraints = false
        return NumberOfPicturesLabel
    }()
    
    private let GuessTextField: UITextField = {
        let GuessTextField: UITextField = UITextField()
        GuessTextField.placeholder = "Computer"
        GuessTextField.textColor = .black
        GuessTextField.font = .init(name: "Helvetica Neue Medium", size: 17)
        GuessTextField.keyboardType = .default
        GuessTextField.borderStyle = .line
        GuessTextField.layer.borderWidth = 1.5
        GuessTextField.backgroundColor = UIColor(named: "LightPurple")
        GuessTextField.isHidden = false
        GuessTextField.translatesAutoresizingMaskIntoConstraints = false
        return GuessTextField
    }()
    
    private let GuessButton: UIButton = {
        let GuessButton: UIButton = UIButton()
        GuessButton.setTitle("Guess", for: .normal)
        GuessButton.setTitleColor(UIColor.white, for: .normal)
        GuessButton.backgroundColor = UIColor(named: "DarkBrown")
        GuessButton.translatesAutoresizingMaskIntoConstraints = false
        return GuessButton
    }()
    
    private let SkipButton: UIButton = {
        let SkipButton: UIButton = UIButton()
        SkipButton.setTitle("Skip", for: .normal)
        SkipButton.setTitleColor(UIColor.white, for: .normal)
        SkipButton.backgroundColor = UIColor(named: "DarkBrown")
        SkipButton.translatesAutoresizingMaskIntoConstraints = false
        return SkipButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let link: String = "https://easterbilby.net/compdle.wtf/api.php"
        let url = URL(string: link)
        guard url != nil else {
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, respone, error in
            if error == nil && data != nil {
                
                //Parse JSON
                let decoder = JSONDecoder()
                do {
                    self.quiz = try decoder.decode(Quiz.self, from: data!)
                    if let imgID = self.quiz.image {
                        self.QuizImage.sd_setImage(with: URL(string: "https://easterbilby.net/compdle.wtf/computers/"+imgID+"\(self.indexOfPic).jpg"), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
                    }
                } catch {
                    self.QuizImage.image = UIImage(named: "error")
                }
            }
        }
        //Make API Call
        dataTask.resume()
        
        view.addSubview(QuizImage)
        view.addSubview(resultTextView)
        view.addSubview(articleTextView)
        view.addSubview(GuessTextField)
        view.addSubview(GuessButton)
        SkipButton.addTarget(self, action: #selector(skipToNextPicture), for: .touchUpInside)
        GuessButton.addTarget(self, action: #selector(guessPicture), for: .touchUpInside)
        view.addSubview(SkipButton)
        view.addSubview(StatusLabel)
        view.addSubview(NumberOfPicturesLabel)
        
        //Function that implements autoLayout for objects in View
        addConstraints()
    }
    
    private func addConstraints () {
        
        //[CREATE ARRAY OF CONSTRAINTS]
        var conStraints = [NSLayoutConstraint]()
        
        //Quiz Image
        conStraints.append(QuizImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Width/4))
        conStraints.append(QuizImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(QuizImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        conStraints.append(QuizImage.heightAnchor.constraint(equalTo: QuizImage.widthAnchor, multiplier: 1))
        
        //Guess TextField
        conStraints.append(GuessTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70))
        conStraints.append(GuessTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70))
        conStraints.append(GuessTextField.topAnchor.constraint(equalTo: QuizImage.bottomAnchor, constant: 60))
        
        //Result TextView
        conStraints.append(resultTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50))
        conStraints.append(resultTextView.topAnchor.constraint(equalTo: QuizImage.bottomAnchor, constant: 30))
        conStraints.append(resultTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50))
        conStraints.append(resultTextView.heightAnchor.constraint(equalTo: resultTextView.widthAnchor, multiplier: 1/3))
        
        //Guess Button
        conStraints.append(GuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -70))
        conStraints.append(GuessButton.topAnchor.constraint(equalTo: resultTextView.bottomAnchor, constant: 10))
        conStraints.append(GuessButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4))
        conStraints.append(GuessButton.heightAnchor.constraint(equalTo: GuessButton.widthAnchor, multiplier: 1/2))
        
        //Skip Button
        conStraints.append(SkipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70))
        conStraints.append(SkipButton.topAnchor.constraint(equalTo: resultTextView.bottomAnchor, constant: 10))
        conStraints.append(SkipButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4))
        conStraints.append(SkipButton.heightAnchor.constraint(equalTo: SkipButton.widthAnchor, multiplier: 1/2))
        
        //Status label
        conStraints.append(StatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(StatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        conStraints.append(StatusLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(Width / 3)))
        
        //Artical TextView
        conStraints.append(articleTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20))
        conStraints.append(articleTextView.topAnchor.constraint(equalTo: StatusLabel.bottomAnchor, constant: 20))
        conStraints.append(articleTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20))
        conStraints.append(articleTextView.heightAnchor.constraint(equalTo: articleTextView.widthAnchor, multiplier: 1/5))
        
        //Number of picture Label
        conStraints.append(NumberOfPicturesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        conStraints.append(NumberOfPicturesLabel.topAnchor.constraint(equalTo: QuizImage.bottomAnchor, constant: 10))
        conStraints.append(NumberOfPicturesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/8))
        conStraints.append(NumberOfPicturesLabel.heightAnchor.constraint(equalTo: NumberOfPicturesLabel.widthAnchor, multiplier: 1/2))
        
        //[ACTIVE CONSTRAINTS]
        NSLayoutConstraint.activate(conStraints)
    }
    
    //EVENT OF BUTTONS
    @objc fileprivate func skipToNextPicture(sender: UIButton)
    {
        self.animateButton(sender)
        StatusLabel.text = "  ❌ Skipped"
        loadNextPic()
    }
    
    @objc fileprivate func guessPicture(sender: UIButton)
    {
        self.animateButton(sender)
        if GuessTextField.text?.isEmpty == true {
            StatusLabel.text = "  ❓ You must enter the data first"
        } else {
            if checkAnswer() == true {
                createItem()
                indexOfPic = 5
                self.QuizImage.sd_setImage(with: URL(string: "https://easterbilby.net/compdle.wtf/computers/"+self.quiz.image!+"\(self.indexOfPic).jpg"), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
                StatusLabel.text = "  ✅ " + self.quiz.name!
                if GuessTextField.isHidden == false {
                    GuessTextField.isHidden = true
                }
                
                if resultTextView.isHidden == true && resultTextView.isEditable == true && articleTextView.isHidden == true && articleTextView.isEditable == true {
                    resultTextView.isHidden = false
                    resultTextView.isEditable = false
                    articleTextView.isHidden = false
                    articleTextView.isEditable = false
                    resultTextView.text = "Congratulations you guessed the correct answer as " + self.quiz.name!
                    articleTextView.text = "Photo by " + self.quiz.photographer!
                    updateTextOfResult()
                    updateTextOfArtical()
                }
                
                if SkipButton.isEnabled == true && GuessButton.isEnabled == true {
                    SkipButton.isEnabled = false
                    GuessButton.isEnabled = false
                    GuessButton.backgroundColor = .gray
                    SkipButton.backgroundColor = .gray
                    SkipButton.setTitleColor(UIColor.black, for: .disabled)
                    GuessButton.setTitleColor(UIColor.black, for: .disabled)
                }
                
            } else if checkAnswer() == false {
                if let answer = self.GuessTextField.text {
                    StatusLabel.text = "  ❌ " + answer
                    loadNextPic()
                }
            }
        }
    }
    //===================================================================
    func loadNextPic() {
        indexOfPic += 1
        if indexOfPic <= 4 {
            NumberOfPicturesLabel.text = "\(indexOfPic + 1)/5"
            self.QuizImage.sd_setImage(with: URL(string: "https://easterbilby.net/compdle.wtf/computers/"+self.quiz.image!+"\(self.indexOfPic).jpg"), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
        } else {
            if SkipButton.isEnabled == true && GuessButton.isEnabled == true {
                SkipButton.isEnabled = false
                GuessButton.isEnabled = false
                GuessButton.backgroundColor = .gray
                SkipButton.backgroundColor = .gray
                SkipButton.setTitleColor(UIColor.black, for: .disabled)
                GuessButton.setTitleColor(UIColor.black, for: .disabled)
                self.QuizImage.sd_setImage(with: URL(string: "https://easterbilby.net/compdle.wtf/computers/"+self.quiz.image!+"\(self.indexOfPic).jpg"), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, completed: nil)
                NumberOfPicturesLabel.isHidden = true
                
                StatusLabel.text = "  ❌ Lose"
                if GuessTextField.isHidden == false {
                    GuessTextField.isHidden = true
                }
                
                if resultTextView.isHidden == true && resultTextView.isEditable == true && articleTextView.isHidden == true && articleTextView.isEditable == true {
                    resultTextView.isHidden = false
                    resultTextView.isEditable = false
                    articleTextView.isHidden = false
                    articleTextView.isEditable = false
                    resultTextView.text = "Sorry but the correct answer was " + self.quiz.name!
                    articleTextView.text = "Photo by " + self.quiz.photographer!
                    updateTextOfResult()
                    updateTextOfArtical()
                }
            }
        }
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
    
    func updateTextOfResult() {
        let attString = NSAttributedString.createHyperLink(for: self.quiz.computer_link!, in: resultTextView.text, as: self.quiz.name!)
        resultTextView.attributedText = attString
        resultTextView.font = UIFont(name: "Helvetica Neue Medium", size: 25)
        resultTextView.textAlignment = .center
    }
    
    func updateTextOfArtical() {
        let attString = NSAttributedString.createHyperLink(for: self.quiz.photographer_link!, in: articleTextView.text, as: self.quiz.photographer!)
        articleTextView.attributedText = attString
        articleTextView.font = UIFont(name: "Helvetica Neue Medium", size: 25)
    }
    
    func checkAnswer() -> Bool {
        if let textInput = GuessTextField.text {
            if textInput.lowercased() == self.quiz.name!.lowercased() {
                return true
            }
        }
        return false
    }
    
    //CORE DATA
    func createItem() {
        let newItem = HistoryItem(context: context)
        
        if let name = self.quiz.name {
            newItem.name = name
        }
        if let img = self.quiz.image {
            newItem.image = img
        }
        newItem.dayComplete = Date.now
        do {
            try context.save()
        } catch {
            fatalError("FAIL")
        }
    }
}
