//
//  UIView+Extensions.swift
//  YoutubeReelz
//
//  Created by Usama Fouad on 30/07/2022.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            }else {
                layer.borderColor = nil
            }
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            }else {
                layer.shadowColor = nil
            }
        }
    }
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var topCornerRightRadius: Bool = false {
        didSet {
            topCornerRightRadius = true
            updateCorners()
        }
    }
    @IBInspectable var topCornerLeftRadius: Bool = false {
        didSet {
            topCornerLeftRadius = true
            updateCorners()
        }
    }
    @IBInspectable var bottomCornerRightRadius: Bool = false {
        didSet {
            bottomCornerRightRadius = true
            updateCorners()
        }
    }
    @IBInspectable var bottomCornerLeftRadius: Bool = false {
        didSet {
            bottomCornerLeftRadius = true
            updateCorners()
        }
    }
    func updateCorners() {
        var corners = CACornerMask()
        if topCornerLeftRadius { corners.formUnion(.layerMinXMinYCorner) }
        if topCornerRightRadius { corners.formUnion(.layerMaxXMinYCorner) }
        if bottomCornerLeftRadius { corners.formUnion(.layerMinXMaxYCorner) }
        if bottomCornerRightRadius{ corners.formUnion(.layerMaxXMaxYCorner) }
        layer.maskedCorners = corners
        layer.cornerRadius = cornerRadius
    }
}
