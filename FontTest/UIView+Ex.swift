//
//  UIView+Ex.swift
//  DLAccounting
//
//  Created by DL on 2021/7/6.
//

import Foundation
import UIKit

extension UIView {
    
    public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    public var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    public var right: CGFloat {
        get { return self.frame.origin.x + self.width }
        set { self.frame.origin.x = newValue - self.width }
    }
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.height }
        set { self.frame.origin.y = newValue - self.height }
    }
    public var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    public var centerX: CGFloat{
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue,y: self.centerY) }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX,y: newValue) }
    }
    
    public var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    
    public var size: CGSize {
        set { self.frame.size = newValue }
        get { return self.frame.size }
    }
    
    @discardableResult
    func bgColor(_ color: UIColor? = .white) -> Self {
        self.backgroundColor = color!
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor? = .white) -> Self {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        return self
    }
    
    @discardableResult
    func corners(_ maskedCorners: CACornerMask) -> Self {
        self.layer.maskedCorners = maskedCorners
        return self
    }
    
    @discardableResult
    func borderWidth(_ width: CGFloat) -> Self {
        self.layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func borderColor(_ color: UIColor? = .white) -> Self {
        self.layer.borderColor = color?.cgColor
        return self
    }
    
    @discardableResult
    func tag(_ tag: Int? = 0) -> Self {
        self.tag = tag!
        return self
    }
    
    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Self {
        self.layer.masksToBounds = masksToBounds
        return self
    }
    
    @discardableResult
    func shadowColor(_ color: UIColor) -> Self {
        self.layer.shadowColor = color.cgColor
        return self
    }
    
    @discardableResult
    func shadowOffset(_ offset: CGSize) -> Self {
        self.layer.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func shadowOpacity(_ opacity: Float) -> Self {
        self.layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func shadowRadius(_ radius: CGFloat) -> Self {
        self.layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func shadowPath(_ path: CGPath) -> Self {
        self.layer.shadowPath = path
        return self
    }
    
    @discardableResult
    func uiEnabled(_ enable: Bool) -> Self {
        self.isUserInteractionEnabled = enable
        return self
    }
    
    @discardableResult
    func hidden(_ hidden: Bool) -> Self {
        self.isHidden = hidden
        return self
    }
    
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

//MARK: UITableView,UITableViewCell,UICollectionView,UICollectionViewCell
public extension UITableView{
    func registerClass(cellType:UITableViewCell.Type){
        register(cellType, forCellReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func dequeueReusableCellForIndexPath<T: UITableViewCell>(indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier , for: indexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier). Ensure you have registered the cell." )
        }
        
        return cell
    }
}

public extension UITableViewCell {
    static var defaultReuseIdentifier:String{
        return String(describing: self)
    }
}

public extension UICollectionView{
    func registerClass(cellType:UICollectionViewCell.Type){
        register(cellType, forCellWithReuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func dequeueReusableCellForIndexPath<T: UICollectionViewCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError( "Failed to dequeue a cell with identifier \(T.defaultReuseIdentifier).  Ensure you have registered the cell" )
        }
        
        return cell
    }
}

public extension UICollectionViewCell{
    static var defaultReuseIdentifier:String{
        return String(describing: self)
    }
}
