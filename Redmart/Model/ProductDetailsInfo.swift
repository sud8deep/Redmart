//
//  ProductDetailsInfo.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductDetailsResponse: Mappable {
    var product: ProductDetailsInfo?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        product <- map["product"]
    }
}

class ProductDetailsInfo: ProductBaseInfo {
    
}
