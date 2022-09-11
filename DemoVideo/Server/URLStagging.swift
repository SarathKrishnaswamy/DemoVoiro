//
//  URLStagging.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import Foundation
import UIKit

enum Environment: String {
    case Production   = "https://api.themoviedb.org/3"
    case Testing     = "http://www.mocky.io"
    case Development  = ""
}

enum Route: String {
  case api  = "/"
}
//https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=81583db45aafc29a226ee50be7fde712

extension URL {
    
    // MARK:- 1 getValues api
    static var getPopularMovies: String {
        let domain = "\(UserDefaults.standard.object(forKey: Key.UserDefaults.stagingURL) ?? "")"
        let api = domain + Route.api.rawValue
        return api + "discover/movie?sort_by=popularity.desc&api_key=81583db45aafc29a226ee50be7fde712"
    }
    

}
