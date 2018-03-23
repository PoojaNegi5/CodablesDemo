//
//  NetworkController.swift
//  CodablesDemo
//
//  Created by Appinventiv on 22/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

class NetworkController
{
   var formattedData = [String:Any]()
    func fetchData(searchedText : String,success :@escaping ([String:Any]) -> Void)
    {
        formattedData = [String:Any]()
        let headers = [
            "Cache-Control": "no-cache",
            "Postman-Token": "b3d4b91f-1c94-40a7-9076-c9947c59ab06"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users/\(searchedText)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(GitHub.self, from: data)
                self.formatData(dataRequired : decodedData)
                success(self.formattedData)
            } catch let err {
                print("Err", err)
            }
        })
        dataTask.resume()
    }
    
    func formatData(dataRequired : GitHub)
    {
        DispatchQueue.main.sync {
            if let profile = dataRequired.avatarUrl {
                let data = try? Data(contentsOf: profile)
                let image :UIImage = UIImage(data: data!)!
                self.formattedData["profile"] = image
            }
        }
        
        self.formattedData["name"] = dataRequired.name ?? "Name not available"

        self.formattedData["company"] = dataRequired.company ?? "Name not available"
        
        self.formattedData["repos"] = dataRequired.repos

        self.formattedData["login"] = dataRequired.login

        self.formattedData["followers"] = dataRequired.followers

        self.formattedData["location"] = dataRequired.location ?? "Location not given"

     }
}
