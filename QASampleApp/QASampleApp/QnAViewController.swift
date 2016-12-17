//
//  QnAViewController.swift
//  QASampleApp
//
//  Created by krishnika agarwal on 17/12/16.
//  Copyright © 2016 krishnika agarwal. All rights reserved.
//

import UIKit

class QnAViewController: UIViewController {

    var postList: [Post] = []
    var pagination = Pagination()
    
    @IBOutlet weak var tableView: UITableView!
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchPostsData()
    }
    
    func fetchPostsData() {
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let url = NSURL(string: "http://api-beta.tinystep.in/v1/thread/recommended?userId=f994ffd1-7c90-4fe2-9582-2cb937600d18&offset=0&count=30&kidAgeStart=-9223372036854775808&kidAgeEnd=378432000000&isQueryForSelf=false&token=5FoItIQ6i9k5054T295zrsfoYTkaaGBd&authProvider=test")
        
        dataTask = defaultSession.dataTask(with: url! as URL) {
            data, response, error in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("####hurray####")
//                    print(response ?? "")
                    
                    if let data = data as NSData? {
                        var jsonError:NSError? = nil
                        let json = JSON(data: data as Data, options:JSONSerialization.ReadingOptions.allowFragments, error: &jsonError)
                        
                        if jsonError != nil {
                            return
                        }
                        else {
                            print(NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) ?? "")
                            if json != nil {
                                self.processServerData(json: json)
                            }
                        }
                    }
                }
            }
        }
        dataTask?.resume()
    }
    
    func processServerData(json: JSON) {
        if json["status"] == "success" {
            for items in json["result"].array! {
                if let postItem = Post(json: items) {
                    self.postList.append(postItem)
                } 
            }
        }
        pagination.currentCount = postList.count
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension QnAViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.postList[indexPath.row].answers.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "answerPost", for: indexPath) as! QnAAnswerTableViewCell
            cell.configureCell(post: postList[indexPath.row])
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "emptyPost", for: indexPath) as! UITableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "headerCell")! as UITableViewCell
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pagination.currentCount - 1 {
            self.fetchPostsData()
        }
    }
    
}
