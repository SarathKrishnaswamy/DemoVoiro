//
//  MovieDetailTableViewCell.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 12/09/22.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var videoCountsLbl: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.thumbImage.layer.cornerRadius = 6.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
