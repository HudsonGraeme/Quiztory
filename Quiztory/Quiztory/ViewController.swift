//
//  ViewController.swift
//  Quiztory
//
//  Created by s on 2018-05-30.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import UIKit

var name = ""
var defaultSize = CGRect()
var defaultNameSize = CGRect()
var defaultNameLabelSize = CGRect()
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        defaultSize = self.Go.frame
        defaultNameSize = self.NameField.frame
        defaultNameLabelSize = self.NameLabel.frame
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    override func loadView() {
        super.loadView()
        self.view.gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        self.view.gradientLayer.gradient = GradientPoint.bottomRightTopLeft.draw()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var WelcomeLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var Go: UIButton!
    var nameCount = 0
    @IBAction func Go(_ sender: Any) {
        if(self.NameField.text!.count >= 3) {
            self.NameLabel.text = "Welcome \(self.NameField.text!)!"
            name = self.NameField.text!
            self.performSegue(withIdentifier: "ToQuiz", sender: self)
        } else if(self.NameField.text!.count == 0) {
            if(nameCount >= 2) {
                self.NameLabel.text = "Bro."
            } else {
                self.NameLabel.text = "Yo pick a name fam"
            }
            nameCount += 1
        } else if(self.NameField.text!.count > 0) {
            if(nameCount >= 2) {
                self.NameLabel.text = "Bro. Relax."
            } else {
                self.NameLabel.text = "A real name please"
            }
            nameCount += 1
        }
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.NameField.frame = CGRect(x: self.NameField.frame.origin.x, y: (keyboardSize.height - 35), width: self.NameField.frame.size.width, height: self.NameField.frame.size.height)
            self.NameLabel.frame = CGRect(x: self.NameLabel.frame.origin.x, y: (keyboardSize.height - 80), width: self.NameLabel.frame.size.width, height: self.NameLabel.frame.size.height)
            self.Go.frame = CGRect(x: (self.Go.frame.origin.x), y: (keyboardSize.height), width: self.Go.frame.size.width, height: self.Go.frame.size.height)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
            self.Go.frame = defaultSize
        self.NameField.frame = defaultNameSize
        self.NameLabel.frame = defaultNameLabelSize
        print("Def")
    }
    
}

extension UIColor {
    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

typealias GradientType = (x: CGPoint, y: CGPoint)

enum GradientPoint {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    
    func draw() -> GradientType {
        switch self {
        case .leftRight:
            return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (x: CGPoint(x: 1.5, y: 1.5), y: CGPoint(x: -0.5, y: -0.5))
        case .topRightBottomLeft:
            return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
        }
    }
}

class GradientLayer : CAGradientLayer {
    var gradient: GradientType? {
        didSet {
            startPoint = gradient?.x ?? CGPoint.zero
            endPoint = gradient?.y ?? CGPoint.zero
        }
    }
}

class GradientView: UIView {
    override public class var layerClass: Swift.AnyClass {
        get {
            return GradientLayer.self
        }
    }
}

protocol GradientViewProvider {
    associatedtype GradientViewType
}

extension GradientViewProvider where Self: UIView, GradientViewType: CAGradientLayer {
    var gradientLayer: GradientViewType {
        return layer as! Self.GradientViewType
    }
}

extension UIView: GradientViewProvider {
    typealias GradientViewType = GradientLayer
}
