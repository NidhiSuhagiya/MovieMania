//
//  MovieDetailVC.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework
import NVActivityIndicatorView
import Reachability
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SDWebImage


class MovieDetailVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var moviePosterImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieDuration: UILabel!
    @IBOutlet weak var ratingBtn: UIButton!
    @IBOutlet weak var addReviewBtn: UIButton!
    @IBOutlet weak var viewReviewBtn: UIButton!
    @IBOutlet weak var imdbRating: UILabel!
    
    var selectedMovie: searchMovieList!
    var getSelectedMovieData : SearchMovieResponseModel!
    var noDataView : NoDataView!
    var errorView : NoDataView!
    var activityIndicatorView : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "MovieMania"
        viewCorners.addCornerToView(view: addReviewBtn)
        viewCorners.addCornerToView(view: viewReviewBtn)
        viewCorners.addShadowToView(view: moviePosterImg)
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 40, width: 50.0, height: 50.0), type: NVActivityIndicatorType.ballClipRotate, color: HexColor(redColor), padding: 0)
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        addNoDataView()
        
        if let imdbId = selectedMovie.imdbId {
            searchMovieDetail(movieId: imdbId)
        } else {
            setMoviewData()
        }
    }
    
    func setMoviewData() {
        if getSelectedMovieData != nil {
            if let img = getSelectedMovieData.poster {
                moviePosterImg.sd_setShowActivityIndicatorView(true)
                moviePosterImg.sd_setIndicatorStyle(.gray)
                moviePosterImg.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "ic_default"))
            } else {
                moviePosterImg.image = UIImage(named: "ic_default")
            }
            movieLanguage.text = (getSelectedMovieData.language != nil) ? getSelectedMovieData.language : "N/A"
            movieTitle.text = (getSelectedMovieData.title != nil) ? getSelectedMovieData.title : "N/A"
            movieReleaseDate.text = (getSelectedMovieData.releaseDate != nil) ? getSelectedMovieData.releaseDate : ((getSelectedMovieData.year != nil) ? getSelectedMovieData.year : "N/A")
            movieDescription.text = (getSelectedMovieData.plot != nil) ? getSelectedMovieData.plot : "N/A"
            movieDirector.text = (getSelectedMovieData.director != nil) ? getSelectedMovieData.director : "N/A"
            movieDuration.text = (getSelectedMovieData.duration != nil) ? getSelectedMovieData.duration : "N/A"
            imdbRating.text = (getSelectedMovieData.imdbRating != nil) ? "\(getSelectedMovieData.imdbRating!)" : "N/A"
        } else {
            if selectedMovie != nil {
                
                if let img = selectedMovie.poster {
                    moviePosterImg.sd_setShowActivityIndicatorView(true)
                    moviePosterImg.sd_setIndicatorStyle(.gray)
                    moviePosterImg.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "ic_default"))
                } else {
                    moviePosterImg.image = UIImage(named: "ic_default")
                }
                
                movieTitle.text = (selectedMovie.title != nil) ? selectedMovie.title : "N/A"
                movieReleaseDate.text = (selectedMovie.year != nil) ? selectedMovie.year : "N/A"
                movieDescription.text = ""
                movieDirector.text = "N/A"
                movieDuration.text = "N/A"
            }
        }
    }
    
    func searchMovieDetail(movieId: String) {
        let searchNewMovieUrl = searchMovieUrl + "&i=" + movieId
        
        alamofireManager.request(searchNewMovieUrl).responseObject{ (response: DataResponse<SearchMovieResponseModel> )in
            
            switch response.result
            {
            case .success(let value):
                if let response = value.response {
                    if response.lowercased() == "true" {
                        self.activityIndicatorView.stopAnimating()
                        //                        self.is_running = false
                        alert.hideView()
                        self.view.endEditing(true)
                        if self.errorView != nil {
                            self.errorView.isHidden = true
                        }
                        if self.noDataView != nil {
                            self.noDataView.isHidden = true
                        }
                        self.getSelectedMovieData = value
                        self.setMoviewData()
                    } else {
                        self.activityIndicatorView.stopAnimating()
                        alert.hideView()
                        self.setMoviewData()
                    }
                }
                break
            case .failure(let error):
                print("error:- \(error.localizedDescription)")
                alert.hideView()
                if (error.localizedDescription) != "cancelled" {
                    self.view.endEditing(true)
                    displayError(str: serverError, view: self)
                    self.displayFailureView()
                }
                break
            }
            }.responseJSON { response in
                print("response searchMovie:- \(response.result.value)")
        }
    }
    
    func displayFailureView() {
        self.noDataView.isHidden = true
        if self.errorView != nil {
            self.errorView.isHidden = false
        } else {
            self.addErrorView()
        }
    }
    
    func addNoDataView() {
        noDataView = NoDataView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.size.width, height: self.view.frame.size.height))
        noDataView.backgroundColor = HexColor(lightGrayColor)
        noDataView.errorIconsHidden = false
        noDataView.configureView(message: "No data found.", image: UIImage(named: "ic_empty")!)
        self.view.addSubview(noDataView)
        self.noDataView.isHidden = true
    }
    
    func addErrorView() {
        errorView = NoDataView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.size.width, height: self.view.frame.size.height))
        errorView.backgroundColor = HexColor(lightGrayColor)
        errorView.errorIconsHidden = false
        errorView.configureView(message: failureViewMsg, image: UIImage(named: "ic_error")!)
        errorView.tapButton.addTarget(self, action: #selector(self.errorButtonClicked), for: .touchUpInside)
        self.view.addSubview(errorView)
        self.errorView.isHidden = false
    }
    
    @objc func errorButtonClicked(sender : UIButton) {
        if (Reachability()?.connection != .none) {
            errorView.isHidden = true
            activityIndicatorView.startAnimating()
            searchMovieDetail(movieId: selectedMovie.imdbId!)
        } else {
            errorView.isHidden = false
        }
    }
    
    @IBAction func ratingBtnClicked(_ sender: Any) {
        showCommentPopup(animated: true)
    }
    
    func showCommentPopup(animated:Bool){
        if animated {
            let popOverVC = storyBoard.instantiateViewController(withIdentifier: "AddRatingView") as! AddRatingView
            popOverVC.modalPresentationStyle = .overFullScreen
            popOverVC.modalTransitionStyle = .crossDissolve
            popOverVC.movieId = (getSelectedMovieData != nil) ? getSelectedMovieData.imdbID : selectedMovie.imdbId
            popOverVC.navigationController?.navigationBar.barTintColor = HexColor(redColor)
            self.navigationController?.present(popOverVC, animated: true, completion: nil)
        }else{
            print("failed to load popup")
        }
    }
    
    @IBAction func viewRatingBtnClicked(_ sender: Any) {
        let popOverVC = storyBoard.instantiateViewController(withIdentifier: "ViewRatingVC") as! ViewRatingVC
        popOverVC.modalPresentationStyle = .overFullScreen
        popOverVC.modalTransitionStyle = .crossDissolve
        popOverVC.movieId = (getSelectedMovieData != nil) ? getSelectedMovieData.imdbID : selectedMovie.imdbId
        popOverVC.navigationController?.navigationBar.barTintColor = HexColor(redColor)
        self.navigationController?.present(popOverVC, animated: true, completion: nil)
    }
}
