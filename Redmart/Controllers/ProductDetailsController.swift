//
//  ProductDetailsController.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductDetailsController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: properties
    var productID: Int = 0
    
    private var productInfo: ProductDetailsInfo! {
        didSet {
            titleLabel.text = productInfo.title
            let sellingPrice = ((productInfo.priceInfo?.promoPrice)! > 0.0) ? productInfo.priceInfo?.promoPrice : productInfo.priceInfo?.price
            priceLabel.text = "$" + String(sellingPrice!)
            descriptionLabel.text = productInfo.productDesc
            imageView.af_cancelImageRequest()
            imageView.image = nil
            let imageURLStr = URLHelper.getImageURL(imagePath: (productInfo.images.first?.path)!)
            imageView.af_setImage(withURL: URL(string: imageURLStr)!)
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
    }
    
    private func initialise() {
        getDetailsInfo()
    }
    
    private func getDetailsInfo() {
        guard productID > 0 else {return}
        _ = APIHelper.getProductDetailsInfo(productID: productID, completionHandler: { (response, error) in
            guard error == nil else {return}
            guard let _ = response,
                let productDetails = response?.product else {return}
            DispatchQueue.main.async {
                self.productInfo = productDetails
            }
        })
    }
}
