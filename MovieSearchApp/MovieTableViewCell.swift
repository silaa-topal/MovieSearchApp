//
//  MovieTableViewCell.swift
//  MovieSearchApp
//
//  Created by Sıla Topal on 21.03.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    
    @IBOutlet weak var movieYearLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    static let identifier = "MovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.Title
        self.movieYearLabel.text = model.Year
        let stringUrl = model.Poster
        if let url = URL(string: stringUrl) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = UIImage(data: imageData)
                }
            }.resume()
            //        if let data = try? Data(contentsOf: URL(string: url)!) {
            //            self.moviePosterImageView.image = UIImage(data: data)
            //        }
        }
        
    }
    
}
