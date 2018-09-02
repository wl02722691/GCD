//
//  ViewController.swift
//  GCD
//
//  Created by 張書涵 on 2018/8/31.
//  Copyright © 2018年 AliceChang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet open weak var nameLbl: UILabel!
    @IBOutlet open weak var addressLbl: UILabel!
    @IBOutlet weak var headLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
            HTTP(apiURLType: .name) { (data, error) in
                print(data)
            }
            
            HTTP(apiURLType: .address) { (data, error) in
                print(data)
            }
            
            HTTP(apiURLType: .head) { (data, error) in
                print(data)
            
        }
    }

    let dispatchGroup = DispatchGroup()
    
    typealias Name = (String?,Error) -> Void
   // let semaphore = DispatchSemaphore(value: 1)
    func HTTP(apiURLType:apiUrl, completion:@escaping Name) {
        
       
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(apiURLType.rawValue)")! as URL)
        
        request.httpMethod = "GET"
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
           
            if (error != nil) {
                print(error)
                completion(nil, HTTPError.Error)
                
            } else {
                let httpResponse = response as? HTTPURLResponse
                let returndata = String(decoding: data!, as: UTF8.self)
                completion(returndata,HTTPError.Error)
                
                self.dispatchGroup.leave()
    
                self.dispatchGroup.notify(queue: .main, execute: {
                    switch apiURLType {
                        
                    case .name:
                        
                        self.nameLbl.text = returndata
                        
                    case .address:
                        
                        self.addressLbl.text = returndata
                        
                    case .head:
                        
                        self.headLbl.text = returndata
                        
                    }
                })
              
                
            }
            
        })
        
     //   semaphore.wait()
        self.dispatchGroup.enter()
        dataTask.resume()
       
    }
}


enum apiUrl:String {
    case name = "https://stations-98a59.firebaseio.com/name.json"
    case address = "https://stations-98a59.firebaseio.com/address.json"
    case head = "https://stations-98a59.firebaseio.com/head.json"
}

enum HTTPError:Error{
    case Error
}

