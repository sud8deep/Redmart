//
//  APIHelper.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class URLHelper {
    private init() {}
    
    class func getCatalogSearchURL() -> String {
        return URLConstants.baseURL + URLConstants.catalogSearchSubURL
    }
    
    class func getImageURL(imagePath: String) -> String {
        return URLConstants.mediaBaseURL + imagePath
    }
}

class APIHelper {
    private init() {}
    
    class func getListInfo(page: Int, pageSize: Int,
                           completionHandler: @escaping (ProductListInfo?, _ errorString: String?) -> Void) -> DataRequest {
        let parameters = APIRequestParamFactory.createGetProductListParams(page: page, pageSize: pageSize)
        let request = Alamofire.request(URLHelper.getCatalogSearchURL(),
                                        method: HTTPMethod.get,
                                        parameters: parameters)
        request.responseObject { (response: DataResponse<ProductListInfo>) in
            guard let _ = response.result.value else {
                return completionHandler(nil, response.result.error?.localizedDescription)
            }
            
            completionHandler(response.result.value, nil)
        }
        
        return request
    }
}
