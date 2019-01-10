//
//  DetailPokemonVC.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class DetailPokemonVC: UIViewController {
    @IBOutlet weak var detailPokeCardCollectionView: UICollectionView!
    var pokemonDetailcards: CardDataWrapper!
    
    // data for collection view
    private var attacks = [AttackDataWrapper]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        detailPokeCardCollectionView.dataSource = self
        detailPokeCardCollectionView.delegate = self
        setUpDetailCardStats()
    }
    
    func setUpDetailCardStats() {
        
        for attack in pokemonDetailcards.attacks {
            attacks.append(attack)
        }
        detailPokeCardCollectionView.reloadData()
        
//        PokeApiClient.searchPokemonCards { (appError, onlineDetailCardStats) in
//            if let appError = appError {
//                print("The app error message is: \(appError.errorMessage())")
//            }
//            if let onlineDetailCardStats = onlineDetailCardStats {
//                self.pokemonDetailcards = onlineDetailCardStats
//            }
//        }
    }
    

    @IBAction func dismissBttn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
}

extension DetailPokemonVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailPC", for: indexPath) as? PokemonDetailCVC else {return UICollectionViewCell()}
        let attacksToSet = attacks[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: pokemonDetailcards.imageUrl) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            }
            if let image = image {
                DispatchQueue.main.async {
                    cell.pokeCardImage.image = image
                }
            }
        }
        cell.attackName.text = attacksToSet.name
        cell.attackDamageLvl.text = attacksToSet.damage
        cell.attackDescription.text = attacksToSet.text
//        cell.attackName.text = detailViewToSet.attacks[indexPath.row].name
//        cell.attackDamageLvl.text = detailViewToSet.attacks[indexPath.row].damage
//        cell.attackDescription.text = detailViewToSet.attacks[indexPath.row].text
        return cell
    }
    
    
}
extension DetailPokemonVC: UICollectionViewDelegate{
    
    
}
