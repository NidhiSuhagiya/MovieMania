//
//  CommentRequestModelVC.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import ObjectMapper

class CommentRequestModelVC: Mappable {
    
    public var userName: String?
    public var userReview: String?
    public var userRating: Float?
    public var movieId: String?

    
    required init?(map: Map) {
        
    }
    
    init(userName: String?, userReview: String?, userRating: Float?, movieId: String?) {
        
        self.userName = userName
        self.userReview = userReview
        self.userRating = userRating
        self.movieId = movieId

        
    }
    
    func mapping(map: Map) {
        userName <- map["userName"]
        userReview <- map["userReview"]
        userRating <- map["userRating"]
        movieId <- map["movieId"]
    }
    
}

