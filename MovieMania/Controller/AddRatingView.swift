//
//  AddRatingView.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyStarRatingView
import ChameleonFramework
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SCLAlertView
import Reachability
import Firebase
import FirebaseFirestore

class AddRatingView: UIViewController, UITextViewDelegate {
    
    @IBOutlet var addCommentOuterView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var txtOuterView: UIView!
    @IBOutlet var commentBtn: UIButton!
    @IBOutlet var txtView: UITextView!
    @IBOutlet var nameTxt: UITextField!

    
    @IBOutlet var ratingOuterView: UIView!
    @IBOutlet var ratingView: SwiftyStarRatingView!
    @IBOutlet var goButton: UIButton!
    
    var userRating : CGFloat!
    var db: Firestore!
    var movieId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        //        UIApplication.shared.statusBarView?.shadowOpacity = 0.8
        
        setPlaceholderToTextField()
        firebaseSetup()
        txtView.delegate = self
        ratingOuterView.isHidden = false
        addCommentOuterView.isHidden = true
        viewCorners.addCornerToView(view: addCommentOuterView, value: 10.0)
        viewCorners.addCornerToView(view: ratingOuterView, value: 10.0)

        viewCorners.addCornerToView(view: txtOuterView, value: 10.0)
        viewCorners.addCornerToView(view: commentBtn)
        viewCorners.addCornerToView(view: cancelBtn)
        viewCorners.addCornerToView(view: goButton)
//        viewCorners.addShadowToView(view: txtOuterView, value: 1.0)
        viewCorners.addCornerToView(view: txtView, value: 10.0)
        viewCorners.addCornerToView(view: nameTxt, value: 10.0)
        viewCorners.addShadowToView(view: txtView, value: 1.0)
        viewCorners.addShadowToView(view: nameTxt, value: 1.0)

//        viewCorners.addBorderCornerTobutton(view : txtView, color: HexColor(darkGrayColor)!, value: 10.0)
//        viewCorners.addBorderCornerTobutton(view : nameTxt, color: HexColor(darkGrayColor)!, value: 10.0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtView.textColor = HexColor(darkGrayColor)
        txtView.text = "Enter your text"
    }
    
    func firebaseSetup() {
            let setting = FirestoreSettings()
        Firestore.firestore().settings = setting
        db = Firestore.firestore()
    }
    
    @IBAction func commentBtnClicked(_ sender: Any) {
        let commentTxt = txtView.text!
        if !checkLength(testStr: commentTxt) {
            alert.hideView()
            displayError(str: "Please enter your name.", view: self)
        } else if !checkLength(testStr: commentTxt) || (txtView.textColor == HexColor(darkGrayColor)) {
            alert.hideView()
            displayError(str: "Please enter comment.", view: self)
        } else {
            if (Reachability()?.connection != .none) {
                userRating = ratingView.value
                addCommentByUser(review: txtView.text!, userRating: Float(userRating), userName: nameTxt.text!)
                
            } else {
                displayError(str: noInternetMessage, view: self)
            }
        }
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addCommentByUser(review : String, userRating : Float, userName: String) {
        //        self.refreshHomeUIDelegate.refreshView(currentIndex: self.currentIndex)
        alert.showWait(loadingTitle, subTitle: "", colorStyle: int_red)
        let info = CommentRequestModelVC(userName: userName, userReview: review, userRating: userRating, movieId: movieId)
        let data_temp = Mapper<CommentRequestModelVC>().toJSON(info)
        var ref: DocumentReference? = nil

        ref = Firestore.firestore().collection("movieMania").document("\(movieId)/user1")
        
        ref?.setData(data_temp, completion: { (error) in
            alert.hideView()
            if let err = error {
                
                displayError(str: err as! String, view: self)
            } else {
                displayError(str: "Review added successfully.", view: self, title: "Success")
                self.dismiss(animated: true, completion: nil)
            }
        })
        
//
//        let info = CommentRequestModelVC(userName: userName, userReview: review, userRating: userRating)
//        let data_temp = Mapper<CommentRequestModelVC>().toJSON(info)
        //            print("view post request:- \(data_temp)")
//        alamofireManager.request(addComment, method: .post, parameters: data_temp, encoding: JSONEncoding(options: []), headers: tokenHeader).responseObject{ (response: DataResponse<ResponseModel> )in
//
//            switch response.result
//            {
//            case .success(let value):
//                if let code = value.code {
//                    switch code {
//                    case 200:
//                        alert.hideView()
//
//                        if let msg = value.message {
//                            displayError(str: msg, view: self, title: "Success")
//                        }
//                        if let commentList = value.viewPostResponseModel?.comment_list {
//                            self.refreshHomeUIDelegate.refreshView(currentIndex: self.currentIndex, commentArr : commentList)
//
//                        }
//                        self.dismiss(animated: true, completion: nil)
//                        break
//                    case 400:
//                        alert.hideView()
//                        clearSession()
//                        redirectToSignUpVC(vc: self)
//                        break
//                    case 401:
//                        alert.hideView()
//                        if let new_token = value.viewPostResponseModel?.new_token {
//                            UserDefaults.standard.set(new_token, forKey: "token")
//                            self.addCommentByUser(review: review, userRating: userRating, userName: userName)
//
//                        }else {
//                            clearSession()
//                            redirectToSignUpVC(vc: self)
//                        }
//                        break
//                    default:
//                        alert.hideView()
//
//                        if let msg = value.message {
//                            displayError(str: msg, view: self, title: "Success")
//                        }
//                        self.dismiss(animated: true, completion: nil)
//
//                    }
//                }
//                break
//            case .failure(let error):
//                print("Request failed with error: \(error.localizedDescription)")
//                alert.hideView()
//                displayError(str: serverError, view: self, title: "Success")
//                self.dismiss(animated: true, completion: nil)
//
//                break
//            }
//
//        }
        //                .responseJSON { response in
        //                    print("response saveUnsavedVideo:- \(response.result.value)")
        //
        //            }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtView.textColor == HexColor(darkGrayColor) {
            txtView.text = nil
            txtView.textColor = HexColor(blackColor)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtView.text.isEmpty {
            txtView.text = "Enter your text"
            txtView.textColor = HexColor(darkGrayColor)
        }
    }
    
    @IBAction func ratingBtnClicked(_ sender: Any) {
        perform(#selector(flip), with: nil, afterDelay: 2)
    }
    
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: ratingOuterView, duration: 0.25, options: transitionOptions, animations: {
            self.ratingOuterView.isHidden = true
        })
        
        UIView.transition(with: addCommentOuterView, duration: 0.25, options: transitionOptions, animations: {
            self.addCommentOuterView.isHidden = false
        })
    }
    
    func setPlaceholderToTextField() {
        var placeHolder = NSMutableAttributedString()
        let Name  = " Enter your name"
        
        // Set the Font
        placeHolder = NSMutableAttributedString(string:Name, attributes: [NSAttributedString.Key.font:UIFont(name: "Lato-Regular", size: 14.0)!])
        
        // Set the color
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value: HexColor(darkGrayColor)!, range:NSRange(location:0,length:Name.characters.count))
        
        // Add attribute
        nameTxt.attributedPlaceholder = placeHolder
    }
}
