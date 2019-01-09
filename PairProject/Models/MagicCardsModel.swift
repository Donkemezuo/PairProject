//
//  MagicCardsModel.swift
//  PairProject
//
//  Created by Donkemezuo Raymond Tariladou on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

struct MagicCards:Codable{
    var cards:[MagicCardDetails]
}
struct MagicCardDetails: Codable{
    var name: String
    var types: [String]
    var subtypes: [String]
    var text: String
    var imageUrl: String?
    var foreignNames: [ForeignNamesDetails]
   
}
struct ForeignNamesDetails: Codable {
    var name: String
    var text: String
    var imageUrl: String?
    var language: String
    var multiverseid: Int
}

