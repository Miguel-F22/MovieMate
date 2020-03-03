//
//  MovieListItemController.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 1/17/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

enum MovieListItemError: Error {
    case failed
}

protocol MovieListItemController {
    func getMovieListItem(name: String, completion: @escaping (Result<Movies, MovieListItemError>) -> Void)
}
