//
//  UIButton+Ex.swift
//  DLAccounting
//
//  Created by DL on 2021/7/6.
//

import Foundation
import UIKit

extension UIButton {
    
    @discardableResult
    func titleColor(_ color: UIColor? = UIColor.darkGray, state: UIControl.State? = .normal) -> Self {
        self.setTitleColor(color!, for: state!)
        return self
    }
    
    @discardableResult
    func title(_ title: String? = "", state: UIControl.State? = .normal) -> Self {
        self.setTitle(title!, for: state!)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage?, state: UIControl.State? = .normal) -> Self {
        self.setImage(image, for: state!)
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func aligment(_ aligment: NSTextAlignment) -> Self {
        self.titleLabel?.textAlignment = aligment
        return self
    }
    
    @discardableResult
    func numLines(_ numberOfLines: Int = 1) -> Self {
        self.titleLabel?.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func target(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) -> Self {
        self.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
}
