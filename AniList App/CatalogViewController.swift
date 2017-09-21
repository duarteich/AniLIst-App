//
//  ViewController.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/20/17.
//  Copyright © 2017 Making your app. All rights reserved.
//

import UIKit
import Kingfisher

class CatalogViewController: UICollectionViewController {
    
    let networkManager = NetworkManager()
    var series = [Serie]()
    
    fileprivate let reuseIdentifier = "AniListCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        getAccessToken()
    }
    
    func getAccessToken() {
        networkManager.getAccessToken { accessToken in
            Session.sharedInstance.accessToken = accessToken
            self.getSeries(accessToken: accessToken)
        }
    }
    
    func getSeries(accessToken: String) {
        print(accessToken)
        networkManager.getSeries(accessToken) { (series) in
            self.series = series
            self.collectionView?.reloadData()
        }
    }

}

extension CatalogViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SerieCollectionViewCell
        
        let url = URL(string: series[indexPath.row].thumbImageUrl!)
        cell.image.kf.setImage(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let controller = storyboard?.instantiateViewController(withIdentifier: "serieDetailsViewController") as! SerieDetailsViewController
        controller.serie = series[index]
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension CatalogViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPeritem = widthPerItem * 1.3
        
        return CGSize(width: widthPerItem, height: heightPeritem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
