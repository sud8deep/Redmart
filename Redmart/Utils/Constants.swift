//
//  Constants.swift
//  Redmart
//
//  Created by sudeep.r on 10/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation

class URLConstants {
    private init() {}
    
    static let baseURL = "https://api.redmart.com"
    static let mediaBaseURL = "https://media.redmart.com/newmedia/200p"
    static let catalogSearchSubURL = "/v1.6.0/catalog/search"
    static let productDetailsSubURL = "/v1.6.0/products/"
}

class StringConstants {
    private init() {}
    
    static let allSales = "all-sales"
    static let noResults = "No Results"
}

class AppConstants {
    private init() {}
    
    static let catalogPageSize: Int = 30
}
