//
//  Header.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import Foundation
import UIKit
import AVFoundation

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
@available(iOS 13.0, *)
let SCENEDELEGATE = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
let COMMONFUNCTION = CommonFunctions.shared

var NETWORK_CONNECTION_STATUS = false

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}

let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad

let IS_IPHONE_5_OR_LESS = UIScreen.main.bounds.size.height <= 568
let IS_IPHONE_X = UIScreen.main.nativeBounds.size.height == 2436
let IS_IPHONE_XS_MAX = UIScreen.main.nativeBounds.size.height == 2688
let IS_IPHONE_XR = UIScreen.main.nativeBounds.size.height == 1792
let IS_IPHONE_NOTCH = IS_IPHONE_XS_MAX || IS_IPHONE_XR || IS_IPHONE_X ? true : false
let IS_IPHONE_6 = UIScreen.main.bounds.size.height == 667
let IS_IPHONE_6PLUS = UIScreen.main.bounds.size.height == 736
let DEVICE_ID = UIDevice.current.identifierForVendor?.uuidString
let IOS_VERSION = UIDevice.current.systemVersion
let PASSWORD_ENCRYPTION_KEY = "1234567891123456"

//MARK:- Google Keys
let GOOGLE_CLIENT_ID = ""


//MARK:- Constants
let IS_LOGGED_IN = "WF_isLoggedIn"
let LOGIN_USERID = "WF_LoginUserID"
let LOGIN_USERNAME = "WF_LoginUserName"

//MARK:- Storyboards
let STORYBOARD_MAIN = UIStoryboard(name:"Main", bundle: Bundle.main)

//MARK:- Generic Font
let TITLE_SMALL     :  CGFloat = IS_IPAD ? 15.0 : 12.0
let TITLE_MEDIUM    :  CGFloat = IS_IPAD ? 17.0 : 14.0
let TITLE_LARGE     :  CGFloat = IS_IPAD ? 19.0 : 16.0
let TITLE_EXTRALARGE:  CGFloat = IS_IPAD ? 21.0 : 18.0

let TEXT_SMALL      :  CGFloat = IS_IPAD ? 19.0 : 17.0
let TEXT_MEDIUM     :  CGFloat = IS_IPAD ? 21.0 : 18.0
let TEXT_LARGE      :  CGFloat = IS_IPAD ? 23.0 : 20.0
let TEXT_EXTRALARGE :  CGFloat = IS_IPAD ? 25.0 : 22.0

//MARK:- Custom Font
let NAVIGATIONBAR_FONT:CGFloat = IS_IPAD ? 22 : 18.0
let BARBUTTON_TEXT_FONT: CGFloat = IS_IPAD ? 20.0 : 15.0
let PROFILE_NAME_FONT :  CGFloat = IS_IPAD ? 45.0 : 40.0
let PROFILE_LIKES_FONT :  CGFloat = IS_IPAD ? 15.0 : 10.0

//MARK:- Alert Message
let NO_NETWORK_ALERT = "Please check your network connection"
let VALID_PHONE_ALERT = "Please enter valid phone number"
let LOGOUT_ALERT = "Are you sure, Do you want to logout?"

extension UIFont{
    class func getLightFontWith(size:CGFloat)->UIFont {
        return UIFont(name: "Manrope-Light", size: size)!
    }
    
    class func getRegularFontWith(size:CGFloat)->UIFont {
        return UIFont(name: "Manrope-Regular", size: size)!
    }
    
    class func getMediumBoldFontWith(size:CGFloat)->UIFont {
        return UIFont(name: "Manrope-Medium", size: size)!
    }
    
    class func getSemiBoldFontWith(size:CGFloat)->UIFont {
        return UIFont(name: "Manrope-SemiBold", size: size)!
    }
    
    class func getBoldFontWith(size:CGFloat)->UIFont {
        return UIFont(name: "Manrope-Bold", size: size)!
    }
    
    class func getExtraBoldFontWith(size:CGFloat)->UIFont {
        return UIFont(name: "Manrope-ExtraBold", size: size)!
    }
    
}
