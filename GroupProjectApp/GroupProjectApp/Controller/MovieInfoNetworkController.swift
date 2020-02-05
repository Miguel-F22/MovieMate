//
//  MovieInfoNetworkController.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 1/27/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

 let api_key2 = "d73981d448f96d767979d8c919ff9338"
 class MovieInfoNetworkController: MovieInfoItemController {
     let session =  URLSession.shared
     
     
     
     func getMovieInfoItem(movie_ID: Int, completion: @escaping (Result<Movie, MovieInfoItemError>) -> Void) {
         let baseURL = URL(string: "https://api.themoviedb.org/3/movie/\(movie_ID)")!

        let query: [String: String] = [
             "api_key": api_key2,
             "language": "en-US"
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
                     let movieList = try decoder.decode(Movie.self, from: data)
                     print(movieList)
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

