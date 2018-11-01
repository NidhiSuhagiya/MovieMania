//
//  NoDataView.swift
//  MindFit
//
//  Created by ob_apple_2 on 8/30/17.
//  Copyright © 2017 ob_apple_2. All rights reserved.
//

import Foundation
import UIKit

class NoDataView: UIView {
    
    var errorLabel : UILabel!
    var tapButton : UIButton!
    var errorIconsHidden : Bool = false
    var textColor = UIColor.black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(message: String, image: UIImage) {
        var differenceY  :CGFloat = 30
        if errorIconsHidden {
            differenceY = 0
        }
        //        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        //        label.numberOfLines = 0
        //        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        //        label.font = font
        //        label.text = text
        //        label.sizeToFit()
        for i in self.subviews {
            i.removeFromSuperview()
        }
//        if errorLabel != nil {
//            self.errorLabel.removeFromSuperview()
//            self.tapButton.removeFromSuperview()
//        }
        errorLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width-20, height: CGFloat.greatestFiniteMagnitude))
        errorLabel.font = UIFont(name: "OpenSans-Regular", size: 13)
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        errorLabel.textColor = textColor
        errorLabel.textAlignment = .center
        errorLabel.text = message
        errorLabel.sizeToFit()
        errorLabel.center = CGPoint(x: self.center.x, y: self.center.y+differenceY-self.frame.origin.y)
        self.addSubview(errorLabel)
        
        if !errorIconsHidden {
            let img = UIImageView(frame: CGRect(x: (self.frame.size.width/2)-20, y: errorLabel.frame.origin.y-(differenceY*2), width: 40, height: 40))
            img.contentMode = .scaleAspectFit
            img.image = image//UIImage(named: "ic_error")
            self.addSubview(img)
        }
        
        tapButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        self.addSubview(tapButton)
    }
    
}
