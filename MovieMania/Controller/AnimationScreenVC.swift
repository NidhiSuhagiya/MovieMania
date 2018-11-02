//
//  AnimationScreenVC.swift
//  MovieMania
//
//  Created by admin on 02/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class AnimationScreenVC : UIViewController {
    
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var outerView: UIView!
    
    @IBOutlet weak var outerViewTopConstant: NSLayoutConstraint!
    
    @IBOutlet weak var lblBottomConstant: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLbl.alpha = 0
        self.outerView.alpha = 0
        configureNavigationBar()
        viewCorners.addCornerToView(view: outerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        change view position for animation
        self.outerViewTopConstant.constant = self.outerViewTopConstant.constant + 60
//        self.lblBottomConstant.constant = self.lblBottomConstant.constant + 50
        setAnimatedView()
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: HexColor("ffffff")!, NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 20)!]
        let navigationItem = self.navigationItem
        navigationItem.title = ""
        navigationController?.navigationBar.barTintColor = HexColor(redColor)
        navigationController?.navigationBar.tintColor = HexColor("ffffff")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let nav = redirectToViewController(vcName: nextVC)
        self.present(nav, animated: true, completion: nil)
    }
    
//    View transition effect
    
    func setAnimatedView() {
            UIView.animate(withDuration: 0.35, delay: 0.3, options: .curveEaseOut, animations: {
                self.outerViewTopConstant.constant = self.outerViewTopConstant.constant - 80
                self.outerView.alpha = 1
                self.titleLbl.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: nil)
    }
}
