//
//  ViewController.swift
//  MovieSearchApp
//
//  Created by Sıla Topal on 20.03.2023.
//

import UIKit
import SafariServices
import SDWebImage

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var table: UITableView!
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        field.delegate = self
    }

    // Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }

    func searchMovies() {
        field.resignFirstResponder()

        guard let text = field.text, !text.isEmpty else {
            return
        }

        let query = text.replacingOccurrences(of: " ", with: "%20")

        movies.removeAll()

        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)&type=movie")!,
                                   completionHandler: { data, response, error in

                                    guard let data = data, error == nil else {
                                        return
                                    }

                                    var result: MovieResult?
                                    do {
                                        result = try JSONDecoder().decode(MovieResult.self, from: data)
                                    }
                                    catch {
                                        print("error")
                                    }

                                    guard let finalResult = result else {
                                        return
                                    }

                                    let newMovies = finalResult.Search
                                    self.movies.append(contentsOf: newMovies)

                                    DispatchQueue.main.async {
                                        self.table.reloadData()
                                    }

        }).resume()

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }

    var selectedMovie: Movie?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        
        selectedMovie = movie
        
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let DetailVC = segue.destination as! MovieDetailsViewController
            DetailVC.movie = selectedMovie
            
        }
        
    }

}

struct MovieResult: Codable {
    let Search: [Movie]
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String

    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }

}

