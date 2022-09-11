//
//  GlobalClass.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import Foundation
import UIKit


class GlobalClass: NSObject {
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    static let sharedInstance: GlobalClass = GlobalClass()
    static let notificationCount = String()
    static let language =  Locale.preferredLanguages[0].components(separatedBy: "-").first ?? Locale.preferredLanguages[0]
    var activityBackgroundView : UIView!
    var myActivityIndicator:UIActivityIndicatorView!
    var connected: Bool!
    var strLabel = UILabel()
    var msgFrame = UIView()
    
    //MARK:- Device Token
    func deviceToken() -> String {
        var token = UserDefaults.standard.string(forKey: "Key.UserDefaults.deviceToken")
        if isEmpty(string: token) {
            token = "Token"
        }
        return token!
    }
 
    open class func stringFromAny(_ value:Any?) -> String {
        if let nonNil = value, !(nonNil is NSNull) {
            return String(describing: nonNil) // "Optional(12)"
        }
        return ""
    }
    
    // MARK: activity
    
    
    public func showOverlay() {
        let view = UIApplication.shared.keyWindow!
        overlayView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        overlayView.center = view.center
        overlayView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 0.5)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            // Fallback on earlier versions
        }
        activityIndicator.color = .systemRed
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    
    
    
    
   
   
    
    // global alert view function
    // MARK: alertView
    func alertView(title: String, message: String, action: String, sender: UIViewController)
    {
        DispatchQueue.main.async(execute: {
            // set alertController for above ios 8 OS
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler:nil))
            sender.present(alert, animated: true, completion: nil)
        })
    }
    
   
    
   
    
    // MARK:- attributed TextField
    func labelAttributedText(totalString: String, rangeofString: String) -> NSMutableAttributedString {
        let text = totalString
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: rangeofString)
        //underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font,value: UIFont.systemFont(ofSize: 15.0), range: range1)
        return underlineAttriString;
    }


    
    // MARK:- isEmpty
    func isEmpty(string: String? = String()) -> Bool {
        if string == nil || (string ?? "").isEmpty || (string.isNilOrEmpty) || string == "<null>" {
            return true
        }
        return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func getCustomerKey() -> String {
        return getUserInfo().value(forKeyPath: "user_key") as? String ?? ""
    }
    func getUserInfo() -> NSDictionary {
        if let getUserInfo = UserDefaults.standard.dictionary(forKey: "userinfo") {
            return getUserInfo as NSDictionary
        }
        return [:]
    }
    func getCurrencySymbol() -> String {
        return "BD"
    }
 
    
    // MARK:- change Label text Color
    func labelTextColor(totalString: String, rangeofString: String, color : UIColor) -> NSMutableAttributedString {
        let underlineAttriString = NSMutableAttributedString(string: totalString)
        let range1 = (totalString as NSString).range(of: rangeofString)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor,value: color, range: range1)
        return underlineAttriString;
    }
    
    //MARK:- Set Dynamic Points
    func setDecimalPoints(value: String) -> String {
        //print(value)
        let pi: Double = Double(value)!
        let gettingValur = String(format:"%.2f",pi)
        
        return gettingValur
    }
    func gradient(size : CGSize, colors : [UIColor]) -> UIImage? {
        // Turn the colors into CGColors
        let cgcolors = colors.map { $0.cgColor }
        
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        // If no context was retrieved, then it failed
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // From now on, the context gets ended if any return happens
        defer { UIGraphicsEndImageContext() }
        
        // Create the Coregraphics gradient
        var locations : [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgcolors as NSArray as CFArray, locations: &locations) else { return nil }
        
        // Draw the gradient
        context.drawLinearGradient(gradient, start: CGPoint(x: 0.0, y: 0.0), end: CGPoint(x: size.width, y: 0.0), options: [])
        // Generate the image (the defer takes care of closing the context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
   
    
   
    

    
}

// MARK:- GET Screen Size
struct Screen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    static var navigationBarHeight: CGFloat {
        let navigation = UINavigationController()
        return UIApplication.shared.statusBarFrame.size.height +
            (navigation.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func hexStringToUIColorwithAlpha (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(0.12)
    )
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
}


