//
//  ViewController.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import ChameleonFramework
import NVActivityIndicatorView
import Reachability
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SDWebImage

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    var activityIndicatorView : NVActivityIndicatorView!
    var backView : UIView!
    var noDataView : NoDataView!
    var errorView : NoDataView!
    var movieList : [searchMovieList] = []
    let searchTxt = UITextField()
    let searchView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth - 80, height: 35))
    let searchImg = UIImageView()
    var is_running : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        self.view.backgroundColor = HexColor(lightGrayColor)
        
        // Do any additional setup after loading the view, typically from a nib.
        tableview.delegate = self
        tableview.dataSource = self
        searchTxt.delegate = self
        addNoDataView()
        addActivityIndicator()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !(movieList.isEmpty) {
            noDataView.isHidden = true
        } else {
            noDataView.isHidden = false
        }
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieListCell") as! MovieListCell
        let item = movieList[indexPath.row]
        cell.movieThumbnail.frame.size.width = cell.outerView.frame.size.width * 0.35
        viewCorners.addShadowToView(view: cell.outerView, value: 2.0)
        
        if let img = item.poster {
            cell.movieThumbnail.sd_setShowActivityIndicatorView(true)
            cell.movieThumbnail.sd_setIndicatorStyle(.gray)
            cell.movieThumbnail.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "ic_default"))
        } else {
            cell.movieThumbnail.image = UIImage(named: "ic_default")
        }
        cell.movieTitleLbl.text = (item.title != nil) ? item.title : "N/A"
        cell.movieReleaseDate.text = (item.year != nil) ? item.year : "N/A"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        nextVC.selectedMovie = movieList[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
//    #MARK:- Set NavigationBar
    
    func configureNavigationBar()
    {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: HexColor("ffffff")!, NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 20)!]
        let navigationItem = self.navigationItem
        navigationItem.title = ""
        
        navigationController?.navigationBar.barTintColor = HexColor(redColor)
        navigationController?.navigationBar.tintColor = HexColor("ffffff")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        searchTxt.leftViewMode = .always
        searchTxt.frame = CGRect(x: searchView.frame.origin.x + 5, y: 0, width: searchView.frame.size.width - 5, height: 35)
        
        let placeholderAlignment = NSMutableParagraphStyle()
        placeholderAlignment.alignment = .center
        let str = NSAttributedString(string: "SEARCH",attributes: [NSAttributedString.Key.foregroundColor: HexColor(darkGrayColor)!, NSAttributedString.Key.font:UIFont(name: "Lato-Regular", size: 14.0)!, NSAttributedString.Key.paragraphStyle: placeholderAlignment])
        let width = (str.width(withConstrainedHeight: 14) / 2) + 15
        searchTxt.attributedPlaceholder = str
        viewCorners.addCornerToView(view: searchTxt)
        searchTxt.textAlignment = .center
        searchTxt.backgroundColor = UIColor.white
        searchImg.frame = CGRect(x: ((searchTxt.frame.size.width / 2) - 10) + width, y: ((searchTxt.frame.size.height / 2)) - 8 , width: 15, height: 15)
        searchImg.contentMode = .scaleAspectFit
        searchImg.image = UIImage(named: "ic_txtSearch")
        searchTxt.addSubview(searchImg)
        navigationItem.titleView = searchTxt
    }
    
    func addActivityIndicator() {
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 40, width: 50.0, height: 50.0), type: NVActivityIndicatorType.ballClipRotate, color: HexColor(redColor), padding: 0)
        backView = UIView(frame: CGRect(x: 0, y: self.view.frame.origin.y - navHeight!, width: self.view.frame.size.width, height: self.view.frame.size.height))
        backView.addSubview(activityIndicatorView)
        backView.backgroundColor = UIColor.clear
        activityIndicatorView.center = backView.center
        tableview.backgroundView = backView
    }
    
    func addNoDataView() {
        noDataView = NoDataView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.size.width, height: self.view.frame.size.height))
        noDataView.backgroundColor = HexColor(lightGrayColor)
        noDataView.errorIconsHidden = false
        noDataView.configureView(message: "No data found.", image: UIImage(named: "ic_empty")!)
        self.view.addSubview(noDataView)
        //        self.noDataView.isHidden = true
    }
    
    func addErrorView() {
        errorView = NoDataView(frame: CGRect(x: 0, y: 0 , width: self.view.frame.size.width, height: self.view.frame.size.height))
        errorView.backgroundColor = HexColor(lightGrayColor)
        errorView.errorIconsHidden = false
        errorView.configureView(message: failureViewMsg, image: UIImage(named: "ic_error")!)
        errorView.tapButton.addTarget(self, action: #selector(self.errorButtonClicked), for: .touchUpInside)
        self.tableview.addSubview(errorView)
        self.errorView.isHidden = false
    }
    
    @objc func errorButtonClicked(sender : UIButton) {
        if (Reachability()?.connection != .none) {
            errorView.isHidden = true
            activityIndicatorView.startAnimating()
            searchMovieByTitle(searchStr: searchTxt.text!)
        } else {
            errorView.isHidden = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTxt {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            if checkLength(testStr: updatedText) {
                searchImg.isHidden = true
                if !is_running {
                    movieList = []
                    tableview.reloadData()
                    noDataView.isHidden = false
                    
                    if (Reachability()?.connection != .none) {
                        if !(noDataView.isHidden) {
                            noDataView.isHidden = true
                            activityIndicatorView.startAnimating()
                        }
                        searchMovieByTitle(searchStr: updatedText)
                    } else {
                        displayError(str: noInternetMessage, view: self)
                        displayFailureView()
                    }
                }
            } else {
                searchImg.isHidden = false
                movieList = []
                tableview.reloadData()
                noDataView.isHidden = false
            }
        }
        return true
    }
    
    //#MARK:-  Search movie by title api
    func searchMovieByTitle(searchStr: String) {
        is_running = true
        let searchNewMovieUrl = searchMovieUrl + "&s=" + searchStr + "&type=movie"
        
        alamofireManager.request(searchNewMovieUrl).responseObject{ (response: DataResponse<ResponseModel> )in
            self.is_running = false
            switch response.result
            {
                
            case .success(let value):
                if let response = value.response {
                    if response.lowercased() == "true" {
                        self.activityIndicatorView.stopAnimating()
                        alert.hideView()
                        self.view.endEditing(true)
                        if self.errorView != nil {
                            self.errorView.isHidden = true
                        }
                        if self.noDataView != nil {
                            self.noDataView.isHidden = true
                        }
                        if let value = value.searchResponse {
                            self.movieList = value
                        } else {
                            self.movieList = []
                        }
                        self.tableview.reloadData()
                    } else {
                        self.activityIndicatorView.stopAnimating()
                        alert.hideView()
                        self.view.endEditing(true)
                        if let error = value.error {
                            if error == "Too many results." {
                                self.displayFailureView()
                            } else if error == "Movie not found!"{
                                self.noDataView.isHidden = false
                            } else {
                                displayError(str: error, view: self)
                            }
                        }
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
            }
//            .responseJSON { response in
//                print("response searchMovie:- \(response.result.value)")
//        }
    }
    
    func displayFailureView() {
        self.noDataView.isHidden = true
        if self.errorView != nil {
            self.errorView.isHidden = false
        } else {
            self.addErrorView()
        }
    }
}

