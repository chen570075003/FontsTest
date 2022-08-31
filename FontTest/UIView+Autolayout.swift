//
//  UIView+Autolayout.swift
//  QCInsghts
//
//  Created by DL on 2021/4/23.
//

import UIKit

/*
 let label = UILabel()
     .adhere(toSuperView: view)
     .layout { (make) in
         make.top.equalToSuperview().offset(80)
         make.centerX.equalToSuperview()
     }
     .config { (label) in
         label.backgroundColor = UIColor.clear
         label.font = UIFont.systemFont(ofSize: 20)
         label.textColor = UIColor.darkGray
         label.text = "Label"
     }
 */

enum AutolayoutType {
    case equal
    case greater
    case less
}

internal extension UIView {
    
    @discardableResult
    func addTo(_ view: UIView) -> Self {
        if view.isKind(of: UIStackView.self) {
            (view as! UIStackView).addArrangedSubview(self)
        } else {
            view.addSubview(self)
        }
        return self
    }
    
//    @discardableResult
//    func layout(_ closure: (_ make: ConstraintMaker) -> Void) -> Self {
//        self.snp.makeConstraints(closure)
//        return self
//    }
    
    @discardableResult
    func fillSuperview() -> Self {
        guard let superview = self.superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        return self
    }

    @discardableResult
    func autoresizing(_ autoresizing: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = autoresizing
        return self
    }
    
    @discardableResult
    func constraint(_ constraint: NSLayoutConstraint, active: Bool? = true) -> Self {
        constraint.isActive = active!
        return self
    }
    
    @discardableResult
    func width(type: AutolayoutType = .equal, constant: CGFloat = 0) -> Self {
        var constraint = NSLayoutConstraint()
        switch type {
        case .equal:
            constraint = widthAnchor.constraint(equalToConstant: constant)
        case .greater:
            constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        case .less:
            constraint = widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        }
        constraint.identifier = "width"
        constraint.isActive = true
        return self
    }
    
    @discardableResult
    func width(_ other: NSLayoutDimension? = nil, constant: CGFloat = 0, mutiplier: CGFloat? = 1.0) -> Self {
        var constraint = NSLayoutConstraint()
        if let other = other {
            constraint = widthAnchor.constraint(equalTo: other, multiplier: mutiplier!, constant: constant)
        } else {
            constraint = widthAnchor.constraint(equalToConstant: constant)
        }
        constraint.identifier = "width"
        constraint.isActive = true
        return self
    }
    
    @discardableResult
    func height(type: AutolayoutType = .equal, constant: CGFloat = 0) -> Self {
        var constraint = NSLayoutConstraint()
        switch type {
        case .equal:
            constraint = heightAnchor.constraint(equalToConstant: constant)
        case .greater:
            constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        case .less:
            constraint = heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        }
        constraint.identifier = "height"
        constraint.isActive = true
        return self
    }
    @discardableResult
    func height(_ other: NSLayoutDimension? = nil, constant: CGFloat = 0, mutiplier: CGFloat? = 1.0) -> Self {
        var constraint = NSLayoutConstraint()
        if let other = other {
            constraint = heightAnchor.constraint(equalTo: other, multiplier: mutiplier!, constant: constant)
        } else {
            constraint = heightAnchor.constraint(equalToConstant: constant)
        }
        constraint.identifier = "height"
        constraint.isActive = true
        return self
    }
    
    @discardableResult
    func centerX(_ centerX: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) -> Self {
        if let centerX = centerX {
            self.anchor(centerXAnchor, otherAchor: centerX, constant: offset, identifer: "centerX")
        } else {
            if let superView = self.superview {
                self.anchor(centerXAnchor, otherAchor: superView.safeAreaLayoutGuide.centerXAnchor, constant: offset, identifer: "centerX")
            }
        }
        return self
    }
    
    @discardableResult
    func centerY(_ centerY: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0) -> Self {
        if let centerY = centerY {
            self.anchor(centerYAnchor, otherAchor: centerY, constant: offset, identifer: "centerY")
        } else {
            if let superView = self.superview {
                self.anchor(centerYAnchor, otherAchor: superView.safeAreaLayoutGuide.centerYAnchor, constant: offset, identifer: "centerY")
            }
        }
        return self
    }
    
    @discardableResult
    func top(_ top: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0) -> Self {
        if let top = top {
            self.anchor(topAnchor, otherAchor: top, constant: offset, identifer: "top")
        } else {
            if let superView = self.superview {
                self.anchor(topAnchor, otherAchor: superView.safeAreaLayoutGuide.topAnchor, constant: offset, identifer: "top")
            }
        }
        return self
    }
    
    @discardableResult
    func bottom(_ bottom: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0) -> Self {
        if let bottom = bottom {
            self.anchor(bottomAnchor, otherAchor: bottom, constant: offset, identifer: "bottom")
        } else {
            if let superView = self.superview {
                self.anchor(topAnchor, otherAchor: superView.safeAreaLayoutGuide.bottomAnchor, constant: offset, identifer: "bottom")
            }
        }
        return self
    }
    
    @discardableResult
    func left(_ left: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) -> Self {
        if let left = left {
            self.anchor(leftAnchor, otherAchor: left, constant: offset, identifer: "left")
        } else {
            if let superView = self.superview {
                self.anchor(leftAnchor, otherAchor: superView.safeAreaLayoutGuide.leftAnchor, constant: offset, identifer: "left")
            }
        }
        return self
    }
    
    @discardableResult
    func right(_ right: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0) -> Self {
        if let right = right {
            self.anchor(rightAnchor, otherAchor: right, constant: offset, identifer: "right")
        } else {
            if let superView = self.superview {
                self.anchor(rightAnchor, otherAchor: superView.safeAreaLayoutGuide.rightAnchor, constant: offset, identifer: "right")
            }
        }
        return self
    }
    
    private func anchor<T:AnyObject>(_ anchor: NSLayoutAnchor<T>? = nil, otherAchor: NSLayoutAnchor<T>, constant: CGFloat = 0, identifer: String) {
        var constraint: NSLayoutConstraint = NSLayoutConstraint()
        if let anchor = anchor {
            constraint = anchor.constraint(equalTo: otherAchor, constant: constant)
        }
        constraint.identifier = identifer
        constraint.isActive = true
    }
    
    func addConstraints(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        if self.superview == nil {
            return []
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        if let top = top {
            let constraint = topAnchor.constraint(equalTo: top, constant: topConstant)
            constraint.identifier = "top"
            constraints.append(constraint)
        }
        
        if let left = left {
            let constraint = leftAnchor.constraint(equalTo: left, constant: leftConstant)
            constraint.identifier = "left"
            constraints.append(constraint)
        }
        
        if let bottom = bottom {
            let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)
            constraint.identifier = "bottom"
            constraints.append(constraint)
        }
        
        if let right = right {
            let constraint = rightAnchor.constraint(equalTo: right, constant: -rightConstant)
            constraint.identifier = "right"
            constraints.append(constraint)
        }
        
        if widthConstant > 0 {
            let constraint = widthAnchor.constraint(equalToConstant: widthConstant)
            constraint.identifier = "width"
            constraints.append(constraint)
        }
        
        if heightConstant > 0 {
            let constraint = heightAnchor.constraint(equalToConstant: heightConstant)
            constraint.identifier = "height"
            constraints.append(constraint)
        }
        
        constraints.forEach { $0.isActive = true }
        return constraints
    }
    
    func removeAllConstraints() {
        constraints.forEach { removeConstraint($0) }
    }
}

