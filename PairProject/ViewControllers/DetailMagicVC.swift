//
//  DetailMagicVC.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class DetailMagicVC: UIViewController {
    @IBOutlet weak var magicCardsVC: DetailMagicCollectionView!
    var cardDetails: MagicCardDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    magicCardsVC.delegate = self
    magicCardsVC.dataSource = self
    }
    
    
    @IBAction func BackButton(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        
    }
}

extension DetailMagicVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardDetails.foreignNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicCardsVC.dequeueReusableCell(withReuseIdentifier: "DetailMC", for: indexPath) as? MagicDetailCVC else {return UICollectionViewCell()}
        let card = cardDetails.foreignNames[indexPath.row]
        cell.language.text = card.language
        cell.name.text = card.name
        cell.text.text = card.text
        ImageHelper.shared.fetchImage(urlString: card.imageUrl ?? "") { (error, imageData) in
            if let error = error{
                print("Error: \(error)")
            } else if imageData != nil {
              cell.magicImage.image = imageData
            }
        }
        return cell
    }
}
extension DetailMagicVC: UICollectionViewDelegateFlowLayout{
    
}
