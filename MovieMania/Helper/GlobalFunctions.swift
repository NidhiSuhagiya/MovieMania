//
//  GlobalFunctions.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import SCLAlertView
import ChameleonFramework
import UIKit

func changeViewColor(view: [UIView], backgroundcolor : String) {
    for i in 0..<view.count {
        view[i].backgroundColor =  UIColor(hexString: backgroundcolor)!
    }
}

func changeButtonColor(view: [UIButton], backgroundcolor : String, fontColor: String) {
    for i in 0..<view.count {
        view[i].backgroundColor = UIColor(hexString: backgroundcolor)!
        view[i].setTitleColor(UIColor(hexString: fontColor), for: .normal)
    }
}

func changeLabelColor(view: [UILabel], backcolor : String, fontColor: String) {
    for i in 0..<view.count {
        view[i].backgroundColor = UIColor(hexString: backcolor)
        view[i].textColor = UIColor(hexString: fontColor)
    }
}

func displayError(str: String, view: UIViewController, title: String? = "Error") {
    let alertView = SCLAlertView()
    if title == "Error" {
        alertView.showError(title!, subTitle: str, closeButtonTitle: "Ok")
    } else {
        alertView.showSuccess(title!, subTitle: str, closeButtonTitle: "Ok", colorStyle: int_red)
    }
    //    let alertview = UIAlertController(title: title, message: str, preferredStyle: .alert)
    //    let okAction = UIAlertAction(title: "Ok", style: .default)
    //    alertview.addAction(okAction)
    //    view.present(alertview, animated: true, completion: nil)
}

func redirectToViewController(vcName: UIViewController) -> UINavigationController{
    let nav = UINavigationController(rootViewController: vcName)
    nav.interactivePopGestureRecognizer?.isEnabled = false
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
    nav.navigationBar.shadowImage = UIImage()
    return nav
}
