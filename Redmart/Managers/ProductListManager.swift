//
//  ProductListManager.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import Foundation
import Alamofire

protocol ProductListManagerProtocol: class {
    func productListManagerFetchedProductListInfo(sender: ProductListManager)
    func productListManager(sender: ProductListManager, didFinishWithError error: String)
}

class ProductListManager {
    weak var delegate: ProductListManagerProtocol?
    
    private(set) var productListInfo: ProductListInfo?
    private var previousRequest: DataRequest?
    
    func getListInfo(page: Int, pageSize: Int = AppConstants.catalogPageSize) {
        previousRequest?.cancel()
        previousRequest = APIHelper.getListInfo(page: page, pageSize: pageSize,
                                                completionHandler:
            { (listInfo, error) in
                if error?.isEmpty == false {
                    self.delegate?.productListManager(sender: self, didFinishWithError: error!)
                } else {
                    if self.productListInfo == nil {
                        self.productListInfo = listInfo
                    } else {
                        self.productListInfo?.page = (listInfo?.page)!
                        self.productListInfo?.pageSize = (listInfo?.pageSize)!
                        self.productListInfo?.products += (listInfo?.products)!
                    }
                    self.delegate?.productListManagerFetchedProductListInfo(sender: self)
                }
                
                self.previousRequest = nil
        })
    }

    func getNextSetOfListInfo() {
        guard let _ = productListInfo else {return}
        if ((productListInfo?.page)! * AppConstants.catalogPageSize) >= (productListInfo?.total)! {
            return
        }

        if previousRequest == nil {
            getListInfo(page: (productListInfo?.page)! + 1)
        }
    }
}
