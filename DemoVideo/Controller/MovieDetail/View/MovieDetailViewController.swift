//
//  MovieDetailViewController.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 12/09/22.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var videoCounts : Int?
    var overView : String?
    var thumbImage : String?
    var releaseDate : String?
    var movieTitle: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.tableFooterView = UIView()
    }
    

}

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableViewCell", for: indexPath) as! MovieDetailTableViewCell
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyy"
        let date = inputFormatter.date(from: self.releaseDate ?? "")
        let dateString = outputFormatter.string(from: date ?? Date())
        DispatchQueue.main.async {
            cell.titleLbl.text = self.movieTitle ?? ""
            cell.dateLbl.text = dateString
            cell.descTextView.text = self.overView ?? ""
            cell.videoCountsLbl.text = "\(self.videoCounts ?? 0)"
        }
        let fullMediaUrl = "https://image.tmdb.org/t/p/original\(thumbImage ?? "")"
        cell.thumbImage.kf.setImage(with:URL.init(string: fullMediaUrl) ?? URL(fileURLWithPath: "") , placeholder: UIImage(named: "dummyProfileImage"), options: [.keepCurrentImageWhileLoading], progressBlock: nil, completionHandler: nil)
        return cell
    }
    
    
}
