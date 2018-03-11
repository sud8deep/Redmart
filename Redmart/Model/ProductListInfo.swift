//
//  ProductListInfo.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductListInfo: Mappable {
    var title: String?
    var total: Int = 0
    var page: Int = 0
    var pageSize: Int = 30
    var products: [PLProductInfo] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title       <- map["title"]
        total       <- map["total"]
        page        <- map["page"]
        pageSize    <- map["page_size"]
        products    <- map["products"]
    }
}

class PLProductInfo: ProductBaseInfo {}


