//
//  APIRequestParamFactory.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation

class APIRequestParamFactory {
    private init() {}
    
    class func createGetProductListParams(page: Int, pageSize: Int) -> [String: Any] {
        var params: [String: Any] = [:]
        params["theme"] = StringConstants.allSales
        params["page"] = page
        params["pageSize"] = pageSize
        return params
    }
}
