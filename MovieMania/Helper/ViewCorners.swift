//
//  ViewCorners.swift
//  MovieMania
//
//  Created by admin on 01/11/18.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit

public class ViewCorners : NSObject {

    func addCornerToButtonWithShadow(button : UIButton) {
        button.layer.cornerRadius = button.frame.size.height/2
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 2
        button.clipsToBounds = false
    }
    
    func addCornerToButtonWithoutShadow(button : UIButton) {
        button.layer.cornerRadius = button.frame.size.height/2
        button.clipsToBounds = true
    }
    
    func makeCircularButton (button : UIButton) {
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    func addCornerToTextField (textField : UITextField) {
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.clipsToBounds = true
    }
    
    func addCornerToTextView (textView : UIView) {
        textView.layer.cornerRadius = textView.frame.size.height/4
        textView.clipsToBounds = true
    }
    
    func addCornerToLabel (label : UILabel) {
        label.layer.cornerRadius = label.frame.size.height/2
        label.clipsToBounds = true
    }

    func addCornerToView (view : UIView) {
        view.layer.cornerRadius = view.frame.size.height/2
        view.clipsToBounds = true
    }
   
    func addCornerToView (view : UIView, value: CGFloat) {
        view.layer.cornerRadius = value
        view.clipsToBounds = true
    }

    func addBorderCornerToView(view : UIView, color: UIColor) {
//        view.layer.cornerRadius = view.frame.size.height/2
//        view.clipsToBounds = true
        view.layer.borderWidth = 0.7//1
        view.layer.borderColor = color.cgColor
    }
    
    func addBorderCornerTobutton(view : UIView, color: UIColor) {
        view.layer.cornerRadius = view.frame.size.height/2
        view.clipsToBounds = true
        view.layer.borderWidth = 0.7//1
        view.layer.borderColor = color.cgColor
    }
    
    func addBorderCornerTobutton(view : UIView, color: UIColor, value: CGFloat) {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderWidth = 0.7//1
        view.layer.borderColor = color.cgColor
    }
    
    func addCornerToView (view : UIView, cornerRadius: CGFloat) {
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
    }
    
    
    func addCornerToImageView (imageView : UIView) {
        imageView.layer.cornerRadius = imageView.frame.size.height/2
        imageView.clipsToBounds = true
    }
    
   
    func addRoundCornerToLeftSide(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width:view.frame.size.height/2, height: view.frame.size.height/2))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addRoundCornerToRightSide(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width:view.frame.size.height/2, height: view.frame.size.height/2))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToLeftSide(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width:view.frame.size.height/4, height: view.frame.size.height/4))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToRightSide(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight],
                                    cornerRadii: CGSize(width:view.frame.size.height/4, height: view.frame.size.height/4))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToLeftMediaBubble(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topRight, .bottomRight, .topLeft],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToLeftMediaBubbleBottomView(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.bottomRight],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToCenterMediaBubble(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.bottomRight,.topRight, .bottomLeft, .topLeft],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToCenterMediaBubbleBottomView(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.bottomRight, .bottomLeft],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToRightMediaBubble(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.topRight, .bottomLeft, .topLeft],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }
    
    func addCornerToRightMediaBubbleBottomView(view : UIView) {
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.bottomLeft],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }

    func addCornerTobottom(view : UIView) {
        
        let maskPath = UIBezierPath(roundedRect: view.bounds,
                                    byRoundingCorners: [.bottomRight, .bottomLeft],
                                    cornerRadii: CGSize(width:view.frame.size.width/15, height: view.frame.size.width/15))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        view.layer.mask = shape
    }

    //Shadow
    func addShadowToView (view : UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 2
        view.clipsToBounds = false
        
    }
    
    func addShadowToView (view : UIView, value: CGFloat) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: value, height: value)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 2
        view.clipsToBounds = false
    }
    
    func addShadowToView (view : UIView, value: CGFloat, color: UIColor) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = CGSize(width: value, height: value)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 2
        view.clipsToBounds = false
    }
}


//class imageCompression {
//    
//    func compressImage(image:UIImage) -> UIImage? {
//        // Reducing file size to a 10th
//        var actualHeight : CGFloat = image.size.height
//        var actualWidth : CGFloat = image.size.width
//        let maxHeight : CGFloat = 600.0
//        let maxWidth : CGFloat = 800.0
//        var imgRatio : CGFloat = actualWidth/actualHeight
//        let maxRatio : CGFloat = maxWidth/maxHeight
//        var compressionQuality : CGFloat = 0.5
//        
//        if (actualHeight > maxHeight || actualWidth > maxWidth){
//            if(imgRatio < maxRatio){
//                //adjust width according to maxHeight
//                imgRatio = maxHeight / actualHeight
//                actualWidth = imgRatio * actualWidth
//                actualHeight = maxHeight
//            }
//            else if(imgRatio > maxRatio){
//                //adjust height according to maxWidth
//                imgRatio = maxWidth / actualWidth
//                actualHeight = imgRatio * actualHeight
//                actualWidth = maxWidth
//            }
//            else{
//                actualHeight = maxHeight
//                actualWidth = maxWidth
//                //                compressionQuality = 1
//            }
//        } else {
//            compressionQuality = 1
//        }
//        
//        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
//        UIGraphicsBeginImageContext(rect.size)
//        image.draw(in: rect)
//        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
//            return nil
//        }
//        
//        guard let imageData = UIImageJPEGRepresentation(img, compressionQuality)else{
//            return nil
//        }
//        UIGraphicsEndImageContext()
//        return UIImage(data: imageData)
//    }
//}

