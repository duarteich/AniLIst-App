//
//  SerieDetailsViewController.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/20/17.
//  Copyright © 2017 Making your app. All rights reserved.
//

import UIKit
import Kingfisher

class SerieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var charactersLabel: UILabel!
    
    let networkManager = NetworkManager()
    var serie: Serie?
    var serieDetails: SerieDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let serie = serie {
            title = serie.title
            let url = URL(string: serie.imageUrl!)
            imageView.kf.setImage(with: url)
            getSerieDetails(serie.id!)
        }
        
    }

    func getSerieDetails(_ serieId: Int) {
        networkManager.getSerieDetails(serieId) { serieDetails in
            self.serieDetails = serieDetails
            self.fillData()
        }
    }
    
    func fillData() {
        if let description = serieDetails?.description {
            self.descriptionLabel.text = description
        }
    }
}
