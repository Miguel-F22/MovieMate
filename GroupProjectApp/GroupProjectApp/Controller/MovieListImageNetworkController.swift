//
//  MovieListImageNetworkController.swift
//  GroupProjectApp
//
//  Created by Josh GImenes on 1/29/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import Foundation
import UIKit

class MovieListImageNetworkController {
    let baseURL = URL(string: "https://image.tmdb.org/t/p/w185")!
    let session =  URLSession.shared

    func fetchImage(path: String, completion:
        @escaping (UIImage?) -> Void) {
        let url = baseURL.appendingPathComponent(path)
        
        let imageTask = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
            //let decoder = JSONDecoder()
            if let data = data,
                let image = UIImage(data: data) {
                
                completion(image)
                
                
            } else {
                print("Either no data was returned, or data was not serialized.")
                
                completion(nil)
                return
            }
        }
        
        
        imageTask.resume()
    }
}




