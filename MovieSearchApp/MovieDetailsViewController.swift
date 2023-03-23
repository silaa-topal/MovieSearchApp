//
//  MovieDetailsViewController.swift
//  MovieSearchApp
//
//  Created by Sıla Topal on 20.03.2023.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var movieImdbID: UILabel!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieYear?.layer.cornerRadius = (movieYear?.frame.size.height)!/2.0
        movieYear?.layer.masksToBounds = true
        
        movieImdbID?.layer.cornerRadius = (movieImdbID?.frame.size.height)!/2.0
        movieImdbID?.layer.masksToBounds = true
        
        movieImage.sd_setImage(with: URL(string: movie!.Poster))
        movieTitle.text = movie?.Title
        movieYear.text = movie?.Year
        movieImdbID.text = movie?.imdbID
    }

}
