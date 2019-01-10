//
//  AllPokeCardInfo.swift
//  PairProject
//
//  Created by Ibraheem rawlinson on 1/9/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

struct AllPokeCardInfo: Codable {
    let cards: [CardDataWrapper]
}
struct CardDataWrapper: Codable {
    let imageUrl: String
    let attacks: [AttackDataWrapper]
}
struct AttackDataWrapper: Codable {
    let name: String
    let text: String
    let damage: String
}
