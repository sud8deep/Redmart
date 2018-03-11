//
//  HomeListViewController.swift
//  Redmart
//
//  Created by sudeep.r on 10/03/18.
//  Copyright © 2018 sudeep.r. All rights reserved.
//

import UIKit

class HomeListViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var mesageLabel: UILabel!
    
    // MARK: Properties
    private let productListCellIdentifier = "ProductListCell"
    private let numberOfItemsInRow = 2
    private let productDetailsVCIdentifier = "ProductDetailsController"
    
    private var productListManager: ProductListManager!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        flowLayout.invalidateLayout()
    }
    
    // MARK: Private methods
    private func initialise() {
        registerCells()
        
        productListManager = ProductListManager()
        productListManager.delegate = self
        
        getCatalogInfo()
        
        APIHelper.sslPinning()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: productListCellIdentifier,
                                      bundle: Bundle.main),
                                forCellWithReuseIdentifier: productListCellIdentifier)
    }
    
    private func getCatalogInfo(page: Int = 0) {
        activityIndicator.startAnimating()
        mesageLabel.text = nil
        productListManager.getListInfo(page: page)
    }
    
    private func handleTapOnProductCell(atIndex indexPath: IndexPath) {
        guard let productInfo = productListManager.productListInfo?.products[indexPath.row] else {return}
        pushProductDetailsVC(productID: productInfo.id)
    }
    
    private func pushProductDetailsVC(productID: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let productDetailsVC = (storyboard.instantiateViewController(
            withIdentifier: productDetailsVCIdentifier) as? ProductDetailsController) else {return}
        productDetailsVC.productID = productID
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
}

// MARK: ProductListManagerProtocol
extension HomeListViewController: ProductListManagerProtocol {
    func productListManagerFetchedProductListInfo(sender: ProductListManager) {
        activityIndicator.stopAnimating()
        
        if productListManager.productListInfo?.products.isEmpty == false {
            mesageLabel.text = nil
        }
        else {
            mesageLabel.text = StringConstants.noResults
        }
        
        collectionView.reloadData()
    }
    
    func productListManager(sender: ProductListManager, didFinishWithError error: String) {
        activityIndicator.stopAnimating()
        mesageLabel.text = error
    }
}

// MARK: UICollectionViewDataSource
extension HomeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = productListManager,
            let _ = productListManager.productListInfo else {
                return 0
        }
        return (productListManager.productListInfo?.products.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productListCellIdentifier,
                                                      for: indexPath) as! ProductListCell
        cell.info = productListManager.productListInfo?.products[indexPath.row]
        
        if indexPath.row == (productListManager.productListInfo?.products.count)! - 3 {
            productListManager.getNextSetOfListInfo()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleTapOnProductCell(atIndex: indexPath)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalAvailableWidth = collectionView.frame.width -
            (CGFloat(numberOfItemsInRow - 1) * flowLayout.minimumInteritemSpacing) -
            (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        let width = totalAvailableWidth / CGFloat(numberOfItemsInRow)
        let itemSize = CGSize(width: width, height: width * 1.5)
        return itemSize
    }
}

