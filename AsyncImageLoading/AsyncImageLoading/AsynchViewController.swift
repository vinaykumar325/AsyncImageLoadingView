//
//  ViewController.swift
//  AsyncImageLoading
//
//  Created by Accion Labs on 30/07/18.
//  Copyright © 2018 Vinay Kumar. All rights reserved.
//

import UIKit
import SwiftyJSON

class AsynchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var userList = [AILUser]()
    @IBOutlet weak var tableView : UITableView!
    var refreshControl: UIRefreshControl!
    var isLoading : Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName:"AILUserImageTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
        isLoading = true
        downloadImageList(url: "http://pastebin.com/raw/wgkJgazE")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(_ sender: Any) {
        tableView.reloadData()
    }
    
    func downloadImageList(url : String){
        
        AILWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:url
            , successCallBack:{ (response : JSON) in
                print("Success \(response)")
                for user  in response.array!
                {self.userList.append(AILUser.init(fromJson: user))
                }
                print("count \(self.userList.count)")
                self.isLoading = false
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
        },
              failureCallBack: { (error : Error) in
                
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "Error", message : "Error while fetching", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AILUserImageTableViewCell
        let user = userList[indexPath.row]
        let userImageModel = user.imageUrl as AILUserImagesModel
        cell.setDataSource(userImageModel: userImageModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 300
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !(Int(indexPath.row + 1) < self.userList.count && self.isLoading == false) {
            self.isLoading = true;
            self.downloadImageList(url: "http://pastebin.com/raw/wgkJgazE")
        }
    }
}

