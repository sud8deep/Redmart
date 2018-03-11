//
//  ProductListCell.swift
//  Redmart
//
//  Created by sudeep.r on 11/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductListCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var productName: UILabel!
    @IBOutlet private weak var sellingPriceLabel: UILabel!
    @IBOutlet private weak var priceBeforeDiscount: UILabel!
    @IBOutlet private weak var outOfStockLabel: UILabel!
    
    var info: PLProductInfo! {
        didSet {
            productName.text = info.title
            let sellingPrice = ((info.priceInfo?.promoPrice)! > 0.0) ? info.priceInfo?.promoPrice : info.priceInfo?.price
            sellingPriceLabel.text = "$" + String(sellingPrice!)
            outOfStockLabel.isHidden = info.inStock
            imageView.af_cancelImageRequest()
            imageView.image = nil
            let imageURLStr = URLHelper.getImageURL(imagePath: (info.images.first?.path)!)
            imageView.af_setImage(withURL: URL(string: imageURLStr)!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }
}
