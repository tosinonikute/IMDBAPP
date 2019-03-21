//
//  DetailViewController.swift
//  IMDBAPP
//
//  Created by MACBOOK PRO on 21/03/2019.
//  Copyright © 2019 MACBOOK PRO. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var visualBlurView: UIVisualEffectView!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var movieRated: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movieName: String = ""
    var movieRating: String = ""
    var movieDesc: String = ""
    var movieImageUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        movieTitle.text = movieName
        movieRated.text = movieRating
        movieSynopsis.text = movieDesc
        self.setMovieImages(movieImageUrl: movieImageUrl)
        
    
    }
    
    override func viewWillLayoutSubviews() {
        movieSynopsis.sizeToFit()
    }
    
    @IBAction func GoBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMovieImages(movieImageUrl: String){
        let movieImageUrl = Constants.IMAGE_URL + Constants.BIG_IMG_PATH + movieImageUrl
        let url = URL(string: movieImageUrl)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {    // execute on main thread
                self.visualBlurView.backgroundColor = UIColor(patternImage: UIImage(data: data)!)
                self.movieImage.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    func setBackgroundImage(imageNamePlusExtension: String){
        self.visualBlurView.backgroundColor = UIColor(patternImage: UIImage(named: imageNamePlusExtension)!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
