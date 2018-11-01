//
//  Constant.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SCLAlertView

let blueColor = "1c1364"
let redColor = "df0037"
let blackColor = "141414"
let darkGrayColor = "707070"
let lightGrayColor = "f4f4f4"
let int_red : UInt = 0xdf0037
let itemCount : Int = 10
let boldFontAttribute = [NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 14.0)]

//objects
let storyBoard = UIStoryboard(name: "Main", bundle:nil)
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let defaults = UserDefaults.standard

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

let viewCorners = ViewCorners()

//Alamofire
let alamofireManager = appDelegate.sessionManager
let requestTimeout : TimeInterval = 35



//application
let app_name = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
let app_version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
let app_package_name = Bundle.main.bundleIdentifier
//let share_text = "I'm using \(app_name)! an awesome app! Get the app at "

//messages
let serverError = "\(app_name) is unable to connect with the server."
//let noConnectionMessage = "\(app_name) is unable to find data. try again."
let noConnectionMessage = "No items found."
let noDataMessage = "No data found. Please Tap here to try again."
let noInternetMessage = "There is no internet connection."
let failureViewMsg = app_name +  " is unable to find data. Please Tap here to try again."

//Alert
let closeButtonAppearance = SCLAlertView.SCLAppearance(
    showCloseButton: false
)
let alert = SCLAlertView(appearance: closeButtonAppearance)
let loadingTitle = "Loading..."
let errorTitle = ""


//Omdb api url
let searchMovieUrl = "http://www.omdbapi.com/?apikey=thewdb"

//Firebase app id
//moviemania-1f9b8

//Api

//let searchMovieByTitle = serverUrl + "registerUserDeviceByDeviceUdid"


