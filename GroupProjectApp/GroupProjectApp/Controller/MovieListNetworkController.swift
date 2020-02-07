//
//  MovieListNetworkController.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 1/17/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

//API KEY: d73981d448f96d767979d8c919ff9338

import Foundation
let api_key = "d73981d448f96d767979d8c919ff9338"
class MovieListNetworkController: MovieListItemController {
    let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")!
    let session =  URLSession.shared
    
    
    
    func getMovieListItem(name: String, completion: @escaping (Result<Movies, MovieListItemError>) -> Void) {
        let query: [String: String] = [
            "api_key": api_key,
            "query": name
        ]
        guard let url = baseURL.withQueries(query) else {
            //completion()
            print("Unable to build URL with supplied queries.")
            return
        }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return completion(.failure(.failed)) }
            
            if (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let movieList = try decoder.decode(Movies.self, from: data)
                    completion(.success(movieList))
                } catch {
                    print(error)
                    completion(.failure(.failed))
                }
                
            } else {
                completion(.failure(.failed))
            }
        }
        task.resume()
    }
}
