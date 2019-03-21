//
//  ViewController.swift
//  IMDBAPP
//
//  Created by MACBOOK PRO on 19/03/2019.
//  Copyright © 2019 MACBOOK PRO. All rights reserved.
//

import UIKit


class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
}

class MovieListViewController: UITableViewController {
    
    var tableArray = [Result] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.title =  "Movies";
        
        parseJSON(
            apiKey: "0d677b16a44d2b5a79edf325bc1ee9b7",
            sortBy: "popularity.desc"
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON(apiKey: String, sortBy: String) {
        
        var components = URLComponents(string: Constants.BASE_URL + "discover/movie")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "sort_by", value: sortBy)
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET" //set http method as GET
        
        self.showHUD(progressLabel: NSLocalizedString("fetching_data", comment: ""))
        
        NetworkLogger.logRequest(request: request)
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(Movies.self, from: content)
                let list = movies.results
                for index in 0...list.count-1 {
                    NSLog(String(list[index].originalTitle))
                }
            
                self.tableArray = movies.results

                DispatchQueue.main.async {
                    self.dismissHUD(isAnimated:true)
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Got an Error all", error.localizedDescription)
            }
        }
        task.resume()
    }
}

extension MovieListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            as! MovieListTableViewCell
        
        let moviesData = self.tableArray[indexPath.row]
        
        cell.rating.text = String(moviesData.voteAverage)
        cell.movieName.text = moviesData.originalTitle
        
        let dateStr = Util.formattedDateFromString(dateString: moviesData.releaseDate, withFormat: "dd MMM, yyyy")
        cell.releaseDate.text = String(dateStr!)
        
        var movieImageUrl = ""
        if(moviesData.posterPath != nil){
            movieImageUrl = Constants.IMAGE_URL + Constants.SMALL_IMG_PATH + moviesData.posterPath
        }
        
        let url = URL(string: movieImageUrl)

        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async() {    // execute on main thread
                cell.movieImage.image = UIImage(data: data)
            }
        }
        task.resume()
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
}
