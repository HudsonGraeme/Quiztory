//
//  LeaderboardController.swift
//  Quiztory
//
//  Created by s on 2018-06-01.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeaderboardController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.view.gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        self.view.gradientLayer.gradient = GradientPoint.bottomRightTopLeft.draw()
        self.tableView.backgroundView?.gradientLayer.colors = [UIColor.purple.cgColor, UIColor.red.cgColor]
        self.tableView.backgroundView?.gradientLayer.gradient = GradientPoint.bottomRightTopLeft.draw()
        self.getTableData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    var highscores = [(JSON())]
    var jsonArray = [JSON]()
    
    @IBOutlet weak var tableView: UITableView!
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highscores.count
    }
    func getTableData(){
        let url = URL(string:"http://api.carspotter.ca/index.php/highscores?transform=1")
        let _ = Alamofire.request(url!, method: .get, encoding: URLEncoding.default, headers: [:]).downloadProgress(queue: DispatchQueue.global(qos: .utility)) {
            progress in
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                let data = response.result.value
                var json = JSON(data ?? 1)
                print(json)
                var i = 0
                while json["highscores"][i] != JSON.null {
                    let records = json["highscores"][i]
                    self.highscores.append(records)
                    i += 1
                }
                self.highscores.removeFirst()
                self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath as IndexPath)

        var name = String()
        if(highscores[indexPath.row]["name"] == JSON.null) {
            name = ""
        } else {
            name = highscores[indexPath.row]["name"].stringValue
        }
        cell.textLabel?.text = name
        let txt2 = UILabel(frame: CGRect(x: (cell.frame.maxX - (cell.frame.width / 2)), y: 0, width: (cell.frame.width / 2), height: cell.frame.height))
        if(highscores[indexPath.row]["score"] != JSON.null) {
            txt2.text = "\(highscores[indexPath.row]["score"].stringValue) Points"
            cell.addSubview(txt2)
        }
        
        return cell
    }
}

