//
//  PokeApiClient.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

final class PokeApiClient {
    static func searchPokemonCards(callBack: @escaping(AppError?, [CardDataWrapper]?)-> Void){
        NetworkHelper.shared.performDataTask(endpointURLString: "https://api.pokemontcg.io/v1/cards?contains=imageUrl,imageUrlHiRes,attacks") { (appError, data, httpResponse) in
            if let appError = appError {
               callBack(appError, nil)
            }
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                callBack(AppError.badStatusCode(String(statusCode)), nil)
                return
            }
            if let data =  data {
                do {
                    let pokeCardInfo = try JSONDecoder().decode(AllPokeCardInfo.self, from: data)
                    callBack(nil, pokeCardInfo.cards)
                } catch {
                    callBack(AppError.decodingError(error), nil)
                }
            }
            
        }
        
    }
}
