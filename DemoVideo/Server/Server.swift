//
//  Server.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Reachability
import RSLoadingView





class APiCall: NSObject {
    var isInternetConnected = Connectivity.isConnectedToNetwork()
    func callAPi(strURL:String , methodType:String , postDictionary:Parameters, completionHandler:@escaping(Bool,JSON,Data) -> ()) {
        
        if isInternetConnected{
            
            let urlRequest = strURL
            RSLoadingView().showOnKeyWindow()
            //GlobalClass.sharedInstance.showOverlay()
            
            let encodeURL : String = urlRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print(encodeURL)
            if methodType == "GET" {
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                print(auth)
                let headers: HTTPHeaders = ["Authorization" : "Bearer", "Accept" : "application/json"]
                let request = AF.request(encodeURL, method: .get,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                
                    switch(response.result) {
                    case .success(_):
                        RSLoadingView.hideFromKeyWindow()
                        print(response.data)
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
            else if methodType == "POST"
            {
                print("Method is Post")
                //let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                let headers: HTTPHeaders = ["Authorization":"application/json"]
                let request = AF.request(encodeURL, method: .post, parameters: postDictionary,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                   
                    switch(response.result) {
                    case .success(_):
                        RSLoadingView.hideFromKeyWindow()
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        
                        break
                        
                    }
                }
            }
            else if methodType == "PUT"
            {
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                let headers: HTTPHeaders = ["Authorization" : "Bearer \(auth)", "Accept" : "application/json"]
                let request = AF.request(encodeURL, method: .put, parameters: postDictionary,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                    print(response)
                    switch(response.result) {
                    case .success(_):
                        RSLoadingView.hideFromKeyWindow()
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
            else if methodType == "DELETE"
            {
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                let headers: HTTPHeaders = ["Authorization" : " Bearer \(auth)", "Accept" : "application/json"]
                let request = AF.request(encodeURL, method: .delete, parameters: postDictionary,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                    switch(response.result) {
                    case .success(_):
                        RSLoadingView.hideFromKeyWindow()
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue), response.data ?? Data())
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
            
        }
        else {
            print("Please check your internet connection")
            COMMONFUNCTION.showInternetAlert()
            
        }
    }
    //MARK:- Upload Multipart data
    func callAPi1(strURL:String , methodType:String , postDictionary:Parameters, completionHandler:@escaping(Bool,JSON) -> ()) {
       // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if  isInternetConnected{
            
            let urlRequest = strURL
          //  print(urlRequest)
            let encodeURL : String = urlRequest.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            print(encodeURL)
           // print(postDictionary)
            if methodType == "GET" {
                //let auth = UserInformation().getJSON().accessToken ?? ""
                //print(auth)
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                //print(auth)
                let headers: HTTPHeaders = ["Authorization" : "Bearer \(auth)", "Accept" : "application/json"]
                //print(headers)
                let request = AF.request(encodeURL, method: .get,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                    print(response.value as? NSDictionary ?? [:])
                    switch(response.result) {
                    case .success(_):
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
            else if methodType == "POST"
            {
                //let auth = UserInformation().getJSON().accessToken ?? ""
                //print(auth)
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                print(auth)
                let headers: HTTPHeaders = ["Authorization" : "Bearer \(auth)", "Accept" : "application/json"]
                let request = AF.request(encodeURL, method: .post, parameters: postDictionary,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                    print(response.value as? NSDictionary ?? [:])
                    switch(response.result) {
                    case .success(_):
                        print(response.value as? NSDictionary ?? [:])
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
            else if methodType == "PUT"
            {
              //  let auth = UserInformation().getJSON().accessToken ?? ""
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                print(auth)
                let headers: HTTPHeaders = ["Authorization" : "Bearer \(auth)", "Accept" : "application/json"]
                let request = AF.request(encodeURL, method: .put, parameters: postDictionary,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                    print(response.value as? NSDictionary ?? [:])
                    switch(response.result) {
                    case .success(_):
                        print(response.value as? NSDictionary ?? [:])
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
            else if methodType == "DELETE"
            {
                //let auth = UserInformation().getJSON().accessToken ?? ""
                let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
                print(auth)
                let headers: HTTPHeaders = ["Authorization" : "Bearer \(auth)", "Accept" : "application/json"]
                let request = AF.request(encodeURL, method: .delete, parameters: postDictionary,encoding: JSONEncoding.default, headers: headers, interceptor: nil)
                request.responseJSON { (response) in
                    print(response.value as? NSDictionary ?? [:])
                    switch(response.result) {
                    case .success(_):
                        if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        } else {
                            guard let responseValue = response.value else { return }
                            completionHandler(true, JSON(responseValue))
                        }
                        break
                    case .failure(_):
                        print(response.value as Any)
                        break
                    }
                }
            }
        }
        else {
            print("Please check your internet connection")
            COMMONFUNCTION.showInternetAlert()
        }
    }
    
   
    
    
    func upload(to url: URL, params: Parameters, imageData:Data?, filename:String?, documentData: Data?, completionHandler:@escaping(Bool,JSON) -> ()) {
        let auth = UserDefaults.standard.value(forKey: "accesstoken") ?? ""
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(auth)", "Accept" : "application/json"]
        RSLoadingView().showOnKeyWindow()
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if let image = imageData {
               // let myfile = 0
                let file = filename
                
                multiPart.append(image, withName: "screen_recording", fileName:file, mimeType: "image/mp4")
            }
            if let document = documentData {
                multiPart.append(document, withName: "Document", fileName: filename, mimeType: "application/pdf")
            }
        }, to: url, method: .post,
           headers: headers)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { response in
                //Do what ever you want to do with response
                print(response.value as? NSDictionary ?? [:])
                RSLoadingView.hideFromKeyWindow()
                switch(response.result) {
                case .success(_):print(response.value as? NSDictionary ?? [:])
                
                if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                    guard let responseValue = response.value else { return }
                    completionHandler(true, JSON(responseValue))
                } else {
                    guard let responseValue = response.value else { return }
                    completionHandler(true, JSON(responseValue))
                }
                    break
                case .failure(_):
                    print(response.value as Any)
                    break
                }
            })
    }
    
    
    func get_post(to url: URL, params: Parameters, completionHandler:@escaping(Bool,Data) -> ()) {
        let headers: HTTPHeaders = ["Authorization" : "Bearer", "Accept" : "application/json"]
        RSLoadingView().showOnKeyWindow()
        if isInternetConnected{
            print(url)
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
        }, to: url, method: .post,
           headers: headers).responseJSON(completionHandler: { response in
                
                switch(response.result) {
                case .success(_)://print(response.value as? NSDictionary ?? [:])
                    RSLoadingView.hideFromKeyWindow()
                    //print(response.data)
                   
                if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 200 {
                    guard let responseValue = response.data else { return }
                    completionHandler(true, responseValue)
                } else {
                    guard let responseValue = response.data else { return }
                    completionHandler(true, responseValue)
                }
                    break
                case .failure(_):
                    print(response.value as Any)
                    break
                }
            })
        }
        else{
            print("Please check your internet connection")
            COMMONFUNCTION.showInternetAlert()
        }
    }
    
    
    
    func uploadMulti(to url: URL, params: Parameters, imageData:[Data?],filename:[String?], documentData: Data?, completionHandler:@escaping(Bool,JSON) -> ()) {
        //let auth = UserInformation().getJSON().accessToken ?? ""
        let headers: HTTPHeaders = ["Authorization" : "Bearer","Accept":"application/json",
                                    "Content-Type":"application/x-www-form-urlencoded"]
        print(url)
        print(params)
        RSLoadingView().showOnKeyWindow()
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            //Todo fix the probelm of image array
            for i in 0..<imageData.count {
                print("The image array added count is\(imageData.count)")
                
                if let image = imageData[i]{ //let file = filename[i] {
                    
                    let file = "filename\(i+1)"
                    multiPart.append(image, withName: "homeworkImage_\(i+1)", fileName: file, mimeType: "image/jpeg")
                }
            }
            print(multiPart)
        }, to: url, method: .post,
           headers: headers)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { response in
                //Do what ever you want to do with response
                RSLoadingView.hideFromKeyWindow()
                print(response.value as? NSDictionary ?? [:])
                switch(response.result) {
                    
                case .success(_):
                    if ("\((response.value  as? NSDictionary ?? [:]).value(forKey: "status") ?? "0")" as NSString).integerValue == 1 {
                        guard let responseValue = response.value else { return }
                        completionHandler(true, JSON(responseValue))
                        print(responseValue)
                    } else {
                        guard let responseValue = response.value else { return }
                        completionHandler(true, JSON(responseValue))
                    }
                    break
                case .failure(_):
                    print(response.value as Any)
                    break
                }
            })
    }
    
   
    //MARK:- Toast view
    func showToast(message : String) {
        
        let lblHeight = self.height(constraintedWidth:UIScreen.main.bounds.size.width-40 , font:UIFont.systemFont(ofSize: 16.0),text:message)
        
        let toastLabel = UILabel(frame: CGRect(x: 20, y: UIScreen.main.bounds.size.height-100, width: UIScreen.main.bounds.size.width-40, height:lblHeight+30))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.systemFont(ofSize: 16.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        let view = UIApplication.shared.keyWindow!
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //MARK:- label height calculate
    func height(constraintedWidth width: CGFloat, font: UIFont, text:String) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
}




