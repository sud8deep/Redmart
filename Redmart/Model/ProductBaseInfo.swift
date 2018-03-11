//
//  ProductBaseInfo.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductBaseInfo: Mappable {
    var id: Int = 0
    var title: String?
    var images: [ProductImageInfo] = []
    var priceInfo: PriceInfo?
    var productDesc: String?
    
    var inStock = false
    var stockStatus: Int = 0 {
        didSet {
            inStock = (stockStatus == 1) ? true : false
        }
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        stockStatus <- map["inventory.stock_status"]
        images      <- map["images"]
        priceInfo   <- map["pricing"]
        productDesc <- map["desc"]
    }
}

class ProductImageInfo: Mappable {
    var path: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        path <- map["name"]
    }
}

class PriceInfo: Mappable {
    var price: Double = 0
    var promoPrice: Double = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        price       <- map["price"]
        promoPrice  <- map["promo_price"]
    }
}
