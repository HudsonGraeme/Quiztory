//
//  HighscoreController.swift
//  
//
//  Created by D. graham on 2018-06-01.
//

import UIKit
import Alamofire
import SwiftyJSON

class HighscoreController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        self.view.gradientLayer.gradient = GradientPoint.bottomRightTopLeft.draw()
        self.ScoreLabel.text = "0"
        sendData()
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(IncrementScore), userInfo: nil, repeats: true)
    }
    var timer = Timer()

    @IBOutlet weak var HighscoreLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var Share: UIButton!
    @IBOutlet weak var Leaderboard: UIButton!
    
    @objc func IncrementScore() {
        if(Int(self.ScoreLabel.text!)! >= totalPoints) {
            self.ScoreLabel.text = "\(totalPoints)"
            timer.invalidate()
        } else {
            self.ScoreLabel.text = String(Int(self.ScoreLabel.text!)! + 43)
        }
    }
    
    func sendData() {
        var request = URLRequest(url: URL(string: "http://api.carspotter.ca/index.php/highscores")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let params = "{\"name\": \"\(name)\", \"score\":\(totalPoints)}"
        let jsonData = params.data(using: .utf8, allowLossyConversion: false)!
        request.httpBody = jsonData
        _ = Alamofire.request(request).responseJSON { response in
            
            let data = response.result.value
            let json = JSON(data)
            if(response.result.isSuccess) {
                
            } else  {
                self.HighscoreLabel.text = "Network Error!"
            }
        }
    }
    @IBAction func Share(_ sender: UIView) {
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let textToShare = totalPoints
            
            if let myWebsite = URL(string: "http://carspotter.ca") {//Enter link to your app here
                UIGraphicsBeginImageContext(view.frame.size)
                self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
                let image2 = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                let objectsToShare = [textToShare, myWebsite, image ?? image2] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                //Excluded Activities
                activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
                //
                
                activityVC.popoverPresentationController?.sourceView = sender
                self.present(activityVC, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
