//
//  CastCharacterNetworkController.swift
//  GroupProjectApp
//
//  Created by Josh Gimenes on 2/10/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation

//API KEY: d73981d448f96d767979d8c919ff9338

class CastCharacterNetworkController: CastCharacterItemController {
    
    
    
    
    func getCastCharacterItem(movieID: String, completion: @escaping (Result<[MovieCharacter], CastCharacterItemError>) -> Void) {
        let baseURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits")!
        let session =  URLSession.shared
        let query: [String: String] = [
            "api_key": api_key
        ]
        guard let url = baseURL.withQueries(query) else {
            //completion()
            print("Unable to build URL with supplied queries.")
            return
        }
        print(url)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return completion(.failure(.failed)) }
            
            if (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let castItem = try decoder.decode(Cast.self, from: data)
                    var subscriptedCastSlice = ArraySlice(castItem.cast)
                    if castItem.cast.count > 10 {
                        subscriptedCastSlice = castItem.cast[0 ..< 10]
                    }
                    let subscriptedCast = Array(subscriptedCastSlice)
                    completion(.success(subscriptedCast))
                    
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
