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
    
    class func getProductDetailsURL(productID: Int) -> String {
        return URLConstants.baseURL + URLConstants.productDetailsSubURL + String(productID)
    }
}

class APIHelper {
    private static var sessionManager = SessionManager()
    
    private init() {}
    
    class func sslPinning() {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "s3-ap-southeast-1amazonaws.com": .pinPublicKeys(
                publicKeys: ServerTrustPolicy.publicKeys(),
                validateCertificateChain: true,
                validateHost: true
            )
        ]
        
        sessionManager = SessionManager(
            serverTrustPolicyManager: ServerTrustPolicyManager(
                policies: serverTrustPolicies
            )
        )
        
        sessionManager.request("https://media.redmart.com/newmedia/200p/i/m/8901012191576_0013_1510203167006.jpg").response { response in
            print(response.error)
        }
    }
    
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
    
    class func getProductDetailsInfo(productID: Int,
                                     completionHandler: @escaping (ProductDetailsResponse?, _ errorString: String?) -> Void) -> DataRequest {
        let request = Alamofire.request(URLHelper.getProductDetailsURL(productID: productID))
        request.responseObject { (response: DataResponse<ProductDetailsResponse>) in
            guard let _ = response.result.value else {
                return completionHandler(nil, response.result.error?.localizedDescription)
            }
            
            completionHandler(response.result.value, nil)
        }
        
        return request
    }
        
}
