//
//  ViewController.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class MagicVC: UIViewController {
    @IBOutlet weak var magicCardColletion: MagicCollectionView!
    
    var magicCards = [MagicCardDetails](){
        didSet {
            DispatchQueue.main.async {
                self.magicCardColletion.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       getMagicCardImages()
        magicCardColletion.dataSource = self
        magicCardColletion.delegate = self
    }



    func getMagicCardImages(){
        MagicCardAPIClient.getMagicCard { (error, data) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                self.magicCards = data
            }
        }
        
        
    }
    
    
    
    
}

extension MagicVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magicCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = magicCardColletion.dequeueReusableCell(withReuseIdentifier: "MC", for: indexPath) as? MagicCardCollectionViewCell else {return UICollectionViewCell()}
        let card = magicCards[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: card.imageUrl ?? "") { (error, imageData) in
            if let error = error{
                print("Error: \(error)")
            } else if imageData != nil {
                cell.image.image = imageData
            }
        }
       
        return cell
        
    }
    
    
}
extension MagicVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let magicCardViewController = storyBoard.instantiateViewController(withIdentifier: "MagicCards") as! DetailMagicVC
        magicCardViewController.modalPresentationStyle = .overCurrentContext
        magicCardViewController.cardDetails = magicCards[indexPath.row]
        present(magicCardViewController, animated: true)
        
    }
}
