//
//  SearchMovieResponseModel.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseModel: Mappable {
    public var searchResponse : [searchMovieList]?
    public var response : String?
    public var totalResults : Int?
    public var error : String?
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        totalResults <- map["totalResults"]
        response <- map["Response"]
        searchResponse <- map["Search"]
        error <- map["Error"]

    }
}

class searchMovieList : Mappable {
    
    public var title : String?
    public var year : String?
    public var imdbId : String?
    public var type : String?
    public var poster : String?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        imdbId <- map["imdbID"]
        type <- map["Type"]
        poster <- map["Poster"]
    }
    
}

class SearchMovieResponseModel : Mappable {
    
    public var title : String?
    public var year : String?
    public var releaseDate : String?
    public var duration : String?
    public var genre : String?
    public var writer : String?
    public var director : String?
    public var actors : String?
    public var language : String?
    public var plot : String?
    public var awards : String?
    public var poster : String?
    public var imdbRating : Double?
    public var imdbID : String?
    public var production : String?
    public var movieRating : [MovieRatings]?

    public var response : String?
    public var error : String?

    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        title <- map["Title"]
        year <- map["Year"]
        releaseDate <- map["Released"]
        genre <- map["Genre"]
        duration <- map["Runtime"]
        writer <- map["Writer"]
        director <- map["director"]
        actors <- map["Actors"]
        plot <- map["Plot"]
        language <- map["Language"]
        awards <- map["Awards"]
        poster <- map["Poster"]
        imdbRating <- map["imdbRating"]
        imdbID <- map["imdbID"]
        production <- map["Production"]
        movieRating <- map["Ratings"]
        response <- map["Response"]
        error <- map["Error"]

    }
}

class MovieRatings : Mappable {
    
    public var source : String?
    public var value : String?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        source <- map["Source"]
        value <- map["Value"]
    }
}
