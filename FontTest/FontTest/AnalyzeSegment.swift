//
//  AnalyzeSegment.swift
//  FontTest
//
//  Created by DL on 2021/11/30.
//

import UIKit

enum SegmentItemPosition {
    case left
    case mid
    case right
}

class SegmentItem: UIView {
    // MARK: Public Properties
    var itemPosition: SegmentItemPosition = .left
    var fillColor: UIColor = .green
    var itemCount: Int = 3
    var itemIndex: Int = 0
    
    // MARK: Private Properties
    private var itemLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()

    private var itemPath: UIBezierPath = {
        let path = UIBezierPath()
        return path
    }()
    
    private struct Constants {
        static let cornor: CGFloat = 20
        static let bigCornor: CGFloat = 60
        static let defaultHeight: CGFloat = 60
        static let offsetScale: CGFloat = 0.075
        static let duration = 0.4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemPath = pathWithSize(frame, index: itemIndex)

        itemPath.fill()
        itemLayer.path = itemPath.cgPath
        itemLayer.fillColor = fillColor.cgColor
    }
    
    // MARK: Public Func
    @discardableResult
    func itemCount(_ count: Int) -> Self {
        self.itemCount = count
        return self
    }
    
    @discardableResult
    func position(_ position: SegmentItemPosition) -> Self {
        self.itemPosition = position
        return self
    }
    
    @discardableResult
    func fillColor(_ color: UIColor) -> Self {
        self.fillColor = color
        return self
    }
    
    func updatePosition(index: Int) {
        
        if index == itemIndex {
            return
        }
        
        itemIndex = index
        
        var position: SegmentItemPosition = .left
        
        if index == 0 {
            position = .left
        } else if itemCount > 2 && index < itemCount - 1 {
            position = .mid
        } else {
            position = .right
        }
        
        itemPosition = position
//
//        layoutIfNeeded()
//        setNeedsLayout()
//
        let path = pathWithSize(frame, index: index)
        
        let fromPath: CGPath = itemLayer.path!
        
        itemLayer.path = path.cgPath
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "path")
//        keyframeAnimation.path = path.cgPath
        keyframeAnimation.values = [fromPath, path.cgPath]
        keyframeAnimation.keyTimes = [0, 1.0]
        keyframeAnimation.isRemovedOnCompletion = false
        keyframeAnimation.autoreverses = false
        keyframeAnimation.fillMode = .backwards
        keyframeAnimation.repeatCount = 1
        keyframeAnimation.duration = Constants.duration
        keyframeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        itemLayer.add(keyframeAnimation, forKey: "animation")
        
        
//        let animation = CABasicAnimation(keyPath: "path")
//        animation.fromValue = fromPath
//        animation.toValue = path.cgPath
//        animation.duration = Constants.duration
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
//        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        itemLayer.add(animation, forKey: "animation")
        
        itemPath = path
    }
    
    // MARK: Private Func
    private func setupUI() {
        
        backgroundColor = .clear
        layer.addSublayer(itemLayer)
    }
    
    func pathWithSize(_ frame: CGRect, index: Int) -> UIBezierPath {
        
        itemPath.removeAllPoints()
        
        let path = UIBezierPath()
        
        var size = frame.size
        var origin = CGPoint.init(x: 0, y: 0)
        
        switch itemPosition {
        case .left:
            
            size = .init(width: frame.size.width / CGFloat(itemCount) + Constants.bigCornor / 2.0, height: frame.size.height)
            
//            itemLayer.position.x = frame.size.width / CGFloat(itemCount) / 2.0
            
            path.move(to: .init(x: origin.x, y: size.height + origin.y))
            
            path.addCurve(to: .init(x: origin.x, y: Constants.cornor + origin.y), controlPoint1: .init(x: origin.x, y: size.height + origin.y), controlPoint2: .init(x: origin.x, y: Constants.cornor + origin.y))
            path.addCurve(to: .init(x: Constants.cornor + origin.x, y: origin.y), controlPoint1: .init(x: origin.x, y: origin.y), controlPoint2: .init(x: Constants.cornor + origin.x, y: origin.y))
//            path.addArc(withCenter: .init(x: 20, y: 20), radius: 20, startAngle: 0.5*2*Double.pi, endAngle: 0.75*2*Double.pi, clockwise: true)
            path.addLine(to: .init(x: size.width - Constants.bigCornor + origin.x, y: origin.y))
            path.addCurve(to: .init(x: size.width - Constants.bigCornor / 2.0 + origin.x, y: size.height / 2.0 + origin.y), controlPoint1: .init(x: size.width - Constants.bigCornor + 20 + origin.x, y: origin.y), controlPoint2: .init(x: size.width - Constants.bigCornor / 2.0 - size.height * Constants.offsetScale + origin.x, y: size.height / 4.0 + origin.y))
            path.addCurve(to: .init(x: size.width + origin.x, y: size.height + origin.y), controlPoint1: .init(x: size.width - Constants.bigCornor / 2.0 + Constants.defaultHeight * Constants.offsetScale + origin.x, y: size.height / 4.0 * 3 + origin.y), controlPoint2: .init(x: size.width - 20 + origin.x, y: size.height + origin.y))
        case .mid:
            
            size = .init(width: frame.size.width / CGFloat(itemCount) + Constants.bigCornor, height: frame.size.height)
            origin = CGPoint.init(x: frame.size.width / CGFloat(itemCount) * CGFloat(index) - Constants.bigCornor / 2.0, y: 0)
            
//            itemLayer.position.x = frame.size.width / CGFloat(itemCount) * CGFloat(index) + size.width / 2.0
            
            path.move(to: .init(x: origin.x, y: size.height + origin.y))
            
            path.addCurve(to: .init(x: Constants.bigCornor / 2.0 + origin.x, y: size.height / 2.0 + origin.y), controlPoint1: .init(x: 20 + origin.x, y: size.height + origin.y), controlPoint2: .init(x: Constants.bigCornor / 2.0 - size.height * Constants.offsetScale + origin.x, y: size.height / 4 * 3 + origin.y))
            path.addCurve(to: .init(x: Constants.bigCornor + origin.x, y: origin.y), controlPoint1: .init(x: Constants.bigCornor / 2.0 + size.height * Constants.offsetScale + origin.x, y: size.height / 4 + origin.y), controlPoint2: .init(x: Constants.bigCornor - 20 + origin.x, y: origin.y))
            path.addLine(to: .init(x: size.width - Constants.bigCornor + origin.x, y: origin.y))
            path.addCurve(to: .init(x: size.width - Constants.bigCornor / 2.0 + origin.x, y: size.height / 2.0 + origin.y), controlPoint1: .init(x: size.width - 38.0 + origin.x, y: origin.y), controlPoint2: .init(x: size.width - Constants.bigCornor / 2.0 - Constants.defaultHeight * Constants.offsetScale + origin.x, y: size.height / 4.0 + origin.y))
            path.addCurve(to: .init(x: size.width + origin.x, y: size.height + origin.y), controlPoint1: .init(x: size.width - Constants.bigCornor / 2.0 + Constants.defaultHeight * Constants.offsetScale + origin.x, y: size.height / 4.0 * 3 + origin.y), controlPoint2: .init(x: size.width - 20 + origin.x, y: size.height + origin.y))
        case .right:
            
            size = .init(width: frame.size.width / CGFloat(itemCount) + Constants.bigCornor / 2.0, height: frame.size.height)
            origin = CGPoint.init(x: frame.size.width - frame.size.width / CGFloat(itemCount) - Constants.bigCornor / 2.0, y: 0)
            
//            itemLayer.position.x = frame.size.width - frame.size.width / CGFloat(itemCount) / 2.0
            
            path.move(to: .init(x: origin.x, y: size.height + origin.y))
            
            path.addCurve(to: .init(x: Constants.bigCornor / 2.0 + origin.x, y: size.height / 2.0 + origin.y), controlPoint1: .init(x: 20 + origin.x, y: size.height + origin.y), controlPoint2: .init(x: Constants.bigCornor / 2.0 - size.height * Constants.offsetScale + origin.x, y: size.height / 4 * 3 + origin.y))
            path.addCurve(to: .init(x: Constants.bigCornor + origin.x, y: origin.y), controlPoint1: .init(x: Constants.bigCornor / 2.0 + size.height * Constants.offsetScale + origin.x, y: size.height / 4 + origin.y), controlPoint2: .init(x: Constants.bigCornor - 20 + origin.x, y: origin.y))
            path.addLine(to: .init(x: size.width - 20.0 + origin.x, y: origin.y))
            path.addCurve(to: .init(x: size.width + origin.x, y: Constants.cornor + origin.y), controlPoint1: .init(x: size.width + origin.x, y: origin.y), controlPoint2: .init(x: size.width + origin.x, y: Constants.cornor + origin.y))
            path.addCurve(to: .init(x: size.width + origin.x, y: size.height + origin.y), controlPoint1: .init(x: size.width + origin.x, y: Constants.cornor + origin.y), controlPoint2: .init(x: size.width + origin.x, y: size.height + origin.y))
        }
        path.addLine(to: .init(x: origin.x, y: size.height + origin.y))
        path.close()
        
        return path
        
    }
}

class AnalyzeSegment: UIView {

    // MARK: Public Properties
    var titles: [String] = ["支出\n0.0", "收入\n0.0", "结余\n0.0"]
    
    // MARK: Private Properties
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexFromString: "#F6F6F7")
        view.layer.cornerRadius = 16
        view.layer.borderColor = UIColor(hexFromString: "#EEEEEE").cgColor
        view.layer.borderWidth = 1.0
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private lazy var item: SegmentItem = SegmentItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: Public Func
    
    
    // MARK: Private Func
    private func setupUI() {
        backgroundColor = .clear
        addConstraints()
    }
    
    private func addConstraints() {
        
        bgView.addTo(self)
            .autoresizing(false)
            .left(leftAnchor, offset: 0)
            .right(rightAnchor, offset: 0)
            .top(topAnchor, offset: 8.0)
            .bottom(bottomAnchor, offset: 1)
        
        item.addTo(self)
            .autoresizing(false)
            .fillSuperview()
            .fillColor(.white)
            .position(.left)
            .itemCount(titles.count)
        
        stackView.addTo(self)
            .autoresizing(false)
            .left(leftAnchor, offset: 0)
            .right(rightAnchor, offset: 0)
            .top(topAnchor, offset: 8.0)
            .bottom(bottomAnchor, offset: 0)
        
        for (index, title) in titles.enumerated() {
            UIButton(type: .custom).addTo(stackView)
                .autoresizing(false)
                .title(title, state: .normal)
                .titleColor(.systemYellow, state: .normal)
                .font(index == 0 ? .boldSystemFont(ofSize: 13) : .systemFont(ofSize: 13))
                .tag(index)
                .target(self, action: #selector(handleAction(_:)), for: .touchUpInside)
                .aligment(.center)
                .numLines(0)
        }
        
    }
    
    @objc private func handleAction(_ sender: UIButton) {
        item.updatePosition(index: sender.tag)
        
        for button in stackView.arrangedSubviews {
            if let button = button as? UIButton {
                if button.tag == sender.tag {
                    button.font(.boldSystemFont(ofSize: 13))
                } else {
                    button.font(.systemFont(ofSize: 13))
                }
            }
        }
        
    }

}
