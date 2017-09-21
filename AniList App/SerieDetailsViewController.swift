//
//  SerieDetailsViewController.swift
//  AniList App
//
//  Created by Christyan Huber Duarte Ibañez on 9/20/17.
//  Copyright © 2017 Making your app. All rights reserved.
//

import UIKit
import Kingfisher

class SerieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var episodesLabel: UILabel!
    
    let networkManager = NetworkManager()
    var serie: Serie?
    var serieDetails: SerieDetail?
    var episodes: [Episode]?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let serie = serie {
            title = serie.title
            let url = URL(string: serie.imageUrl!)
            imageView.kf.setImage(with: url)
            getSerieDetails(serie.id!)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
        }
        
    }

    func getSerieDetails(_ serieId: Int) {
        networkManager.getSerieDetails(serieId) { serieDetails in
            self.serieDetails = serieDetails
            self.episodes = serieDetails.episodes
            self.tableView.reloadData()
            self.fillData()
        }
    }
    
    func fillData() {
        if let description = serieDetails?.description {
            do {
                let descriptionAttr = try NSAttributedString(
                    data: description.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                    options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                    documentAttributes: nil)
                descriptionLabel.attributedText = descriptionAttr
                descriptionLabel.font = UIFont.systemFont(ofSize: 13)
                descriptionLabel.textColor = UIColor.white
            } catch let error {
                print(error)
            }
        }
        if let characters = serieDetails?.characters {
            var charactersString = ""
            for character in characters {
                var characterName = ""
                if let nameFirst = character.nameFirst {
                    characterName = nameFirst
                }
                if let nameLast = character.nameLast {
                    characterName = characterName + " " + nameLast
                }
                if characterName.isEmpty {
                    continue
                }
                charactersString =  charactersString + characterName + ", "
            }
            charactersLabel.text = charactersString
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let episodes = episodes {
            episodesLabel.isHidden = false
            if episodes.count == 0 {
                episodesLabel.isHidden = true
            }
            return episodes.count
        } else {
            episodesLabel.isHidden = true
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.text = episodes![indexPath.row].name
        return cell
    }
}
