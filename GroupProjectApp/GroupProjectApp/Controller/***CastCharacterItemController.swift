//
//  CastCharacterItemController.swift
//  GroupProjectApp
//
//  Created by Josh Gimenes on 2/10/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

enum CastCharacterItemError: Error {
    case failed
}

protocol CastCharacterItemController {
    func getCastCharacterItem(movieID: String, completion: @escaping (Result<[MovieCharacter], CastCharacterItemError>) -> Void)
}
