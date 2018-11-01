//
//  SearchMovieRequestModel.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchMoviewRequestModel: Mappable {
   
    public var s: String?
    public var type: String? = "movie"

    
    required init?(map: Map) {
        
    }
    
    init(t: String?, type: String?) {
        
        self.s = t
        self.type = type

    }
    
    func mapping(map: Map) {
        s <- map["s"]
        type <- map["type"]
    }
    
}
