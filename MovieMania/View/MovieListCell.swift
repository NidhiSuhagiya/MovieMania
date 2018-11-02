//
//  MovieListCell.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyStarRatingView

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet var movieThumbnail: UIImageView!
    @IBOutlet var movieTitleLbl: UILabel!
    @IBOutlet var movieReleaseDate: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        movieThumbnail.frame.size.width = outerView.frame.size.width * 0.4
    }

}


class ReviewListCell: UITableViewCell {
    
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet var userProfileImg: UIImageView!
    @IBOutlet var userNameLbl: UILabel!
    @IBOutlet var userReviewLbl: UILabel!

}
