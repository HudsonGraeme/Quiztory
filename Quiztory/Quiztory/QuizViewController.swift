//
//  QuizViewController.swift
//  Quiztory
//
//  Created by s on 2018-05-31.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import UIKit



typealias Question = (Question: String, Answers: [Answer])
typealias Answer = (title: String, isCorrect: Bool)

var questions = [Question]()
var totalPoints = Int()

class QuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.gradientLayer.colors = [UIColor.red.cgColor, UIColor.purple.cgColor]
        self.view.gradientLayer.gradient = GradientPoint.bottomLeftTopRight.draw()
        self.CorrectLabel.text?.removeAll()
        self.QuestionLabel.text?.removeAll()
        self.Answer1.isHidden = false
        self.Answer2.isHidden = false
        self.Answer3.isHidden = false
        self.Answer4.isHidden = false
        self.Answer1.setTitle("", for: .normal)
        self.Answer2.setTitle("", for: .normal)
        self.Answer3.setTitle("", for: .normal)
        self.Answer4.setTitle("", for: .normal)
        points = 0
        totalPoints = 0
        self.Answer1.layer.cornerRadius = 15.0
        self.Answer2.layer.cornerRadius = 15.0
        self.Answer3.layer.cornerRadius = 15.0
        self.Answer4.layer.cornerRadius = 15.0
        populateQuestions()
        newQuestion()
        // Do any additional setup after loading the view.
        
    }
    
    let Corrects = ["Right!", "Correct!", "You got it!", "Nice one!", "You're a god!", "On a roll!", "Way to go!"]
    let Incorrects = ["Sorry, incorrect", "Wrong", "Try again", "Oof, try again", "Sorry, worng."]
    var timer = Timer()
    var timer2 = Timer()
    var points = Int()
    var time = Int()
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer4: UIButton!
    @IBOutlet weak var CorrectLabel: UILabel!
    @IBOutlet weak var PointsLabel: UIBarButtonItem!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var LeaderboardButton: UIBarButtonItem!
    
    var currentQuestion = Question(String(), [Answer(String(), Bool())])
    @objc func newQuestion() {
        if (questions.count >= 1) {
            points = 1000
            self.CorrectLabel.text = ""
            self.time = 0
            self.TimeLabel.text = ""
            self.Answer1.isEnabled = true
            self.Answer2.isEnabled = true
            self.Answer3.isEnabled = true
            self.Answer4.isEnabled = true
            print("C1 :: ", questions.count, "\r\n")
            let rndm = Int(arc4random_uniform(UInt32(questions.count)))//# of Questions!!!
            var q = questions[rndm]
            print("C2 ::  \(questions.count)\r\n")
                questions.remove(at: rndm)
            currentQuestion = q
            self.QuestionLabel.text = q.Question
            self.Answer1.setTitle(q.Answers[0].title, for: .normal)
            self.Answer2.setTitle(q.Answers[1].title, for: .normal)
            self.Answer3.setTitle(q.Answers[2].title, for: .normal)
            self.Answer4.setTitle(q.Answers[3].title, for: .normal)
            self.Answer1.titleLabel?.numberOfLines = 2
            self.Answer1.titleLabel?.adjustsFontSizeToFitWidth = true
            self.Answer1.titleLabel?.textAlignment = .center
            self.Answer2.titleLabel?.numberOfLines = 2
            self.Answer2.titleLabel?.adjustsFontSizeToFitWidth = true
            self.Answer2.titleLabel?.textAlignment = .center
            self.Answer3.titleLabel?.numberOfLines = 2
            self.Answer3.titleLabel?.adjustsFontSizeToFitWidth = true
            self.Answer3.titleLabel?.textAlignment = .center
            self.Answer4.titleLabel?.numberOfLines = 2
            self.Answer4.titleLabel?.adjustsFontSizeToFitWidth = true
            self.Answer4.titleLabel?.textAlignment = .center
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(DealWithPoints), userInfo: nil, repeats: true)
            timer2 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(incrementTime), userInfo: nil, repeats: true)
            print("C3 :: \(questions.count)\r\n")
        } else {
            self.QuestionLabel.text = "\(totalPoints)"
            self.TimeLabel.text = ""
            self.Answer1.isHidden = true
            self.Answer2.isHidden = true
            self.Answer3.isHidden = true
            self.Answer4.isHidden = true
            let button = UIButton(frame: CGRect(x: 16, y: 527, width: 343, height: 40))
            button.setTitle("Play Again", for: .normal)
            button.backgroundColor = UIColor(red: 63.0, green: 172.0, blue: 255.0, alpha: 1.0)
            button.layer.cornerRadius = 10.0
            button.tag = 101
            button.addTarget(self, action: #selector(DidLoad), for: .touchUpInside)
            self.view.addSubview(button)
            self.performSegue(withIdentifier: "ToScore", sender: self)
        }
    }
    @objc func DidLoad() {
        if let tag = self.view.viewWithTag(101) {
            tag.removeFromSuperview()
        }
        viewDidLoad()
    }
    
    @objc func DealWithPoints() {
        if (points <= 0) {
            print("no points b")
        } else {
            if (points <= 400) {
                points -= 50
            } else if (points > 400) {
                points -= 100
            }
        }
    }
    @objc func incrementTime() {
        time += 1
        var str = ""
        if(time == 1) {
            str = "Second"
        } else {
            str = "Seconds"
        }
        self.TimeLabel.text = "\(time) \(str)"
    }
    @IBAction func Answer1(_ sender: Any) {
        self.Answer1.isEnabled = false
        self.Answer2.isEnabled = false
        self.Answer3.isEnabled = false
        self.Answer4.isEnabled = false
        timer2.invalidate()
        let Corrndm = Int(arc4random_uniform(UInt32(Corrects.count - 1)))
        let Incorrndm = Int(arc4random_uniform(UInt32(Incorrects.count - 1)))
        if (currentQuestion.Answers[0].isCorrect) {
            self.CorrectLabel.text = Corrects[Corrndm]
            points += 300
        } else {
            self.CorrectLabel.text = Incorrects[Incorrndm]
            points -= 1000
        }
        QuestionAnswered()
    }
    @IBAction func Answer2(_ sender: Any) {
        self.Answer1.isEnabled = false
        self.Answer2.isEnabled = false
        self.Answer3.isEnabled = false
        self.Answer4.isEnabled = false
        timer2.invalidate()
        let Corrndm = Int(arc4random_uniform(UInt32(Corrects.count - 1)))
        let Incorrndm = Int(arc4random_uniform(UInt32(Incorrects.count - 1)))
        if (currentQuestion.Answers[1].isCorrect) {
            self.CorrectLabel.text = Corrects[Corrndm]
            points += 300
        } else {
            self.CorrectLabel.text = Incorrects[Incorrndm]
            points -= 1000
        }
        QuestionAnswered()
    }
    @IBAction func Answer3(_ sender: Any) {
        self.Answer1.isEnabled = false
        self.Answer2.isEnabled = false
        self.Answer3.isEnabled = false
        self.Answer4.isEnabled = false
        timer2.invalidate()
        let Corrndm = Int(arc4random_uniform(UInt32(Corrects.count - 1)))
        let Incorrndm = Int(arc4random_uniform(UInt32(Incorrects.count - 1)))
        if (currentQuestion.Answers[2].isCorrect) {
            self.CorrectLabel.text = Corrects[Corrndm]
            points += 300
        } else {
            self.CorrectLabel.text = Incorrects[Incorrndm]
            points -= 1000
        }
        QuestionAnswered()
    }
    @IBAction func Answer4(_ sender: Any) {
        self.Answer1.isEnabled = false
        self.Answer2.isEnabled = false
        self.Answer3.isEnabled = false
        self.Answer4.isEnabled = false
        timer2.invalidate()
        let Corrndm = Int(arc4random_uniform(UInt32(Corrects.count - 1)))
        let Incorrndm = Int(arc4random_uniform(UInt32(Incorrects.count - 1)))
        if (currentQuestion.Answers[3].isCorrect) {
            self.CorrectLabel.text = Corrects[Corrndm]
            points += 300
        } else {
            self.CorrectLabel.text = Incorrects[Incorrndm]
            points -= 1000
        }
        QuestionAnswered()
    }
    func QuestionAnswered() {
        timer.invalidate()
        totalPoints += points
        self.PointsLabel.title = String(totalPoints)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(newQuestion), userInfo: nil, repeats: false)
    }
   
    @IBAction func LeaderboardButton(_ sender: Any) {
        self.performSegue(withIdentifier: "QuizToLeaderBoard", sender: self)
    }
    
}
