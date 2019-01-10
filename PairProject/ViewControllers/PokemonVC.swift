//
//  PokemonVC.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class PokemonVC: UIViewController {
    @IBOutlet weak var pokeCollectionView: UICollectionView!
    var pokemoncards = [CardDataWrapper](){
        didSet {
            DispatchQueue.main.async {
                self.pokeCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      pokeCollectionView.delegate = self
    pokeCollectionView.dataSource = self
        findCardCollection()
    }
   private func findCardCollection(){
    PokeApiClient.searchPokemonCards { (appError, onlineCards) in
        if let appError = appError {
            print("error message states: \(appError.errorMessage())")
        }
        if let onlineCards = onlineCards {
//            print("found \(onlineCards.count) pokemon cards")
            self.pokemoncards = onlineCards
        }
    }
    }
}

extension PokemonVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemoncards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PC", for: indexPath) as? PokemonCardCollectionViewCell else {return UICollectionViewCell()}
        let pokeCardsToSet = pokemoncards[indexPath.row]
        ImageHelper.shared.fetchImage(urlString: pokeCardsToSet.imageUrl) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            }
            if let image = image {
                DispatchQueue.main.async {
                    cell.pokemonCardImage.image = image
                }
            }
        }
        return cell
    }
}
extension PokemonVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 125, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let pokemonViewController = storyBoard.instantiateViewController(withIdentifier: "PokemonCards") as! DetailPokemonVC
        pokemonViewController.modalPresentationStyle = .overCurrentContext
        let pokemonCard = pokemoncards[indexPath.row]
        pokemonViewController.pokemonDetailcards = pokemonCard
        present(pokemonViewController, animated: true)
    }
    
}
