//
//  ViewController.swift
//  GroupProjectApp
//
//  Created by Miguel Figueroa on 1/14/20.
//  Copyright © 2020 Miguel Figueroa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let movieListController: MovieListItemController = MovieListNetworkController()
    var movieListItem: Movies?
        /// Josh was here

    override func viewDidLoad() {
        super.viewDidLoad()
        movieListItemCall()
        /// Do any additional setup after loading the view.
    }

    func movieListItemCall() {
        movieListController.getMovieListItem(name: "Jack+Reacher") { response in
        DispatchQueue.main.async {
            switch response {
                case .success(let movieListItem):
                    self.movieListItem = movieListItem
                    DispatchQueue.main.async {
   
                    }
                case .failure:
                    let alert = UIAlertController(title: "Error", message: "Failed to load data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        }
        }
    }
    
// tommy wuz here
}

