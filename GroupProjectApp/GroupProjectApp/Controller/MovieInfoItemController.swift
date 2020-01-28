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
    func getMovieInfoItem(movie_ID: String, completion: @escaping (Result<Movie, MovieInfoItemError>) -> Void)
}
