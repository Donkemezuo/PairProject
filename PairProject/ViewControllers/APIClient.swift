//
//  APIClient.swift
//  PairProject
//
//  Created by Donkemezuo Raymond Tariladou on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

final class MagicCardAPIClient {

static func getMagicCard(completionHandler:@escaping(AppError?,[MagicCardDetails]?) -> Void){
    
    let magicCardUrlString = "https://api.magicthegathering.io/v1/cards?contains=imageUrl"
    NetworkHelper.shared.performDataTask(endpointURLString: magicCardUrlString) { (error, data, response) in
        if let error = error {

            completionHandler(error,nil)
        } else if let data = data {
            do {
        let magicCards = try JSONDecoder().decode(MagicCards.self,from: data)
                let details = magicCards.cards
                let filteredDetails = details.filter{$0.imageUrl != nil}
                completionHandler(nil, filteredDetails)
            } catch {
                completionHandler(AppError.decodingError(error),nil)
            }
        }
    }
    
}
}
