//
//  ViewRatingVC.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import SwiftyStarRatingView
import NVActivityIndicatorView
import ChameleonFramework
import Reachability

class ViewRatingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var outerView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet weak var noDataView: UIView!
    
    var reviewList : [QueryDocumentSnapshot] = []
    var movieId : String!
    var db: Firestore!
    var errorView : NoDataView!
    var backView : UIView!
    var activityIndicatorView : NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.outerView.frame.size.height = self.view.frame.size.height * 0.7
        self.outerView.frame.size.width = self.view.frame.size.height * 0.9
        viewCorners.addCornerToView(view: outerView, value: 10.0)
        viewCorners.addShadowToView(view: headerView )
        addActivityIndicator()
        
        //        Firebase setup
        let setting = FirestoreSettings()
        Firestore.firestore().settings = setting
        db = Firestore.firestore()
        fetchReviewByMovieId()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReviewListCell
        viewCorners.addCornerToView(view: cell.userProfileImg)
        let item = reviewList[indexPath.row]
        cell.userProfileImg.image = UIImage(named: "ic_defaultProfile")
        if let name = item["userName"] as? String {
            cell.userNameLbl.text = name
        } else {
            cell.userNameLbl.text = ""
        }
        
        if let rating = item["userRating"] as? Double {
            cell.ratingView.value = CGFloat(rating)
        }
        
        if let review = item["userReview"] as? String {
            cell.userReviewLbl.text = review
        } else {
            cell.userReviewLbl.text = ""
            
        }
        return cell
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    #MARK:- Fetch data from database
    
    func fetchReviewByMovieId() {
        noDataView.isHidden = true
        activityIndicatorView.startAnimating()
        
        let docRef = db.collection("movieMania").document("Movies").collection("\(movieId!)")
        docRef.getDocuments(completion: { (document, error) in
            if let doc = document {
                print("Document data: \(doc.documents.description)")
                self.reviewList = doc.documents
                self.noDataView.isHidden = !(self.reviewList.isEmpty)
                self.tableView.isHidden = self.reviewList.isEmpty
                self.tableView.separatorStyle = .singleLine
                self.tableView.reloadData()
            } else {
                self.noDataView.isHidden = false
                self.tableView.isHidden = true
                print("Document does not exist")
            }
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    func displayFailureView() {
        self.noDataView.isHidden = true
        if self.errorView != nil {
            self.errorView.isHidden = false
        } else {
            self.addErrorView()
        }
    }
    
    func addErrorView() {
        errorView = NoDataView(frame: CGRect(x: self.outerView.frame.origin.x, y: self.outerView.frame.origin.y , width: self.outerView.frame.size.width, height: self.outerView.frame.size.height))
        errorView.backgroundColor = HexColor(lightGrayColor)
        errorView.errorIconsHidden = false
        errorView.configureView(message: failureViewMsg, image: UIImage(named: "ic_error")!)
        errorView.tapButton.addTarget(self, action: #selector(self.errorButtonClicked), for: .touchUpInside)
        self.outerView.addSubview(errorView)
        self.errorView.isHidden = false
    }
    
    @objc func errorButtonClicked(sender : UIButton) {
        if (Reachability()?.connection != .none) {
            errorView.isHidden = true
            activityIndicatorView.startAnimating()
            fetchReviewByMovieId()
        } else {
            errorView.isHidden = false
        }
    }
    
    func addActivityIndicator() {
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 40, width: 50.0, height: 50.0), type: NVActivityIndicatorType.ballClipRotate, color: HexColor(redColor), padding: 0)
        backView = UIView(frame: CGRect(x: 0, y: self.tableView.frame.origin.y, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        backView.addSubview(activityIndicatorView)
        backView.backgroundColor = UIColor.clear
        activityIndicatorView.center = backView.center
        tableView.backgroundView = backView
        tableView.separatorStyle = .none
        activityIndicatorView.startAnimating()
    }
    
}
