//
//  CommonFunctions.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import Foundation
import UIKit

class CommonFunctions{
    
    static let shared = CommonFunctions()
    
    func checkIfValidFontName(name_: String) -> String {
        var fName = ""
        var tmp_: [String] = []
        if name_.contains("Light") || name_.contains("Regular") || name_.contains("Medium") || name_.contains("Bold") {
            var name__ = "Light"
            if name_.contains("Light") {
                tmp_ = name_.components(separatedBy: "Light")
            }
            else if name_.contains("Regular") {
                name__ = "Regular"
                tmp_ = name_.components(separatedBy: "Regular")
            }
            else if name_.contains("Medium") {
                name__ = "Medium"
                tmp_ = name_.components(separatedBy: "Medium")
            }
            else {
                name__ = "Bold"
                tmp_ = name_.components(separatedBy: "Bold")
            }
            
            if tmp_.count > 0 {
                for i in 0..<tmp_.count {
                    if i == tmp_.count - 1 {
                        fName = fName.replacingOccurrences(of: " ", with: "")
                        if name__ != "Regular" {
                            if fName.contains("-") { fName.append("\(name__)") }
                            else { fName.append("-\(name__)") }
                        }
                    }
                    else {
                        fName.append("\(tmp_[i])")
                    }
                }
            }
        }
        else {
            fName = name_.replacingOccurrences(of: " ", with: "")
        }
        return fName
    }
    func checkIfValidFontColor(color_:String) -> String {
        var fColor = color_
        if !color_.hasPrefix("#") {
            fColor = "#".appending("\(color_)")
        }
        return fColor
    }
    
    func getTitleFontSize(size:String) -> CGFloat {
        switch size.uppercased() {
        case "MEDIUM", "2":
            return TITLE_MEDIUM
        case "LARGE", "3":
            return TITLE_LARGE
        case "EXTRALARGE", "4":
            return TITLE_EXTRALARGE
        default:
            return TITLE_SMALL
        }
    }
    func getTextFontSize(size:String) -> CGFloat {
        switch size.uppercased() {
        case "MEDIUM", "2":
            return TEXT_MEDIUM
        case "LARGE", "3":
            return TEXT_LARGE
        case "EXTRALARGE", "4":
            return TEXT_EXTRALARGE
        default:
            return TEXT_SMALL
        }
    }
    
    //MARK:Directory Path
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func getPath(rootName: String) -> URL {
        let documentsDirectory = getDocumentsDirectory()
        let folderPath = documentsDirectory.appendingPathComponent(rootName)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: folderPath.path) {}
        else {
            do {
                try fileManager.createDirectory(atPath: folderPath.path, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        return folderPath
    }
    
    //MARK:ALERT
    func showAlert(msg:String, vc:UIViewController) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        vc.present(alert, animated: true)
    }
    func showInternetAlert() {
        let alert = UIAlertController(title: "Oops!", message: NO_NETWORK_ALERT, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
        }))
        if #available(iOS 13.0, *) {
            SCENEDELEGATE.window?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    

}

