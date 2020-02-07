//
//  MovieInfoItemController.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 1/27/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

enum MovieInfoItemError: Error {
    case failed
}

protocol MovieInfoItemController {
    func getMovieInfoItem(movie_ID: Int, completion: @escaping (Result<AMovie, MovieInfoItemError>) -> Void)
}
