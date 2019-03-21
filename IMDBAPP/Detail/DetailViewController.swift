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
    var movieRating: Double = 0.0
    var movieDesc: String = ""
    var movieImageUrl: String = ""
    
    // rating assets
    
    @IBOutlet weak var ratingOne: UIImageView!
    @IBOutlet weak var ratingTwo: UIImageView!
    @IBOutlet weak var ratingThree: UIImageView!
    @IBOutlet weak var ratingFour: UIImageView!
    @IBOutlet weak var ratingFive: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        movieTitle.text = movieName
        movieRated.text = String(movieRating)
        movieSynopsis.text = movieDesc
        self.setMovieImages(movieImageUrl: movieImageUrl)
        
        setRatingStar(rating: Int(movieRating))
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
    
    func setRatingStar(rating: Int){
        
        let rateImageStr = "rate-star-button"
        switch rating {
        case 1...2:
            ratingOne.image = UIImage(named: rateImageStr)!
        case 2...4:
            ratingOne.image = UIImage(named: rateImageStr)!
            ratingTwo.image = UIImage(named: rateImageStr)!
        case 4...6:
            ratingOne.image = UIImage(named: rateImageStr)!
            ratingTwo.image = UIImage(named: rateImageStr)!
            ratingThree.image = UIImage(named: rateImageStr)!
        case 6...8:
            ratingOne.image = UIImage(named: rateImageStr)!
            ratingTwo.image = UIImage(named: rateImageStr)!
            ratingThree.image = UIImage(named: rateImageStr)!
            ratingFour.image = UIImage(named: rateImageStr)!
        case 8...10:
            ratingOne.image = UIImage(named: rateImageStr)!
            ratingTwo.image = UIImage(named: rateImageStr)!
            ratingThree.image = UIImage(named: rateImageStr)!
            ratingFour.image = UIImage(named: rateImageStr)!
            ratingFive.image = UIImage(named: rateImageStr)!
        default:
            ratingOne.image = UIImage(named: rateImageStr)!
        }
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
