//
//  ViewController.swift
//  FontTest
//
//  Created by DL on 2021/11/15.
//

import UIKit

class ViewController: UIViewController {

    var bundleRequest: NSBundleResourceRequest? = nil
    
    private var progressSceneKVOContext = 0
    
    var item: AnalyzeSegment = AnalyzeSegment()
    
    private lazy var width: NSLayoutConstraint = item.widthAnchor.constraint(equalToConstant: 142)
    private lazy var left: NSLayoutConstraint = item.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.bgColor(.systemGray6)
        
        item.addTo(view)
            .autoresizing(false)
            .top(view.safeAreaLayoutGuide.topAnchor, offset: 16)
            .right(view.rightAnchor, offset: -16.0)
            .constraint(left)
            .height(constant: 60)
        
//        SegmentItem()
//            .addTo(view)
//            .autoresizing(false)
//            .top(view.safeAreaLayoutGuide.topAnchor, offset: 80)
//            .left(view.leftAnchor, offset: 16.0)
//            .width(constant: 172)
//            .height(constant: 60)
//            .fillColor(.green)
//            .position(.mid)
//        SegmentItem()
//            .addTo(view)
//            .autoresizing(false)
//            .top(view.safeAreaLayoutGuide.topAnchor, offset: 150)
//            .left(view.leftAnchor, offset: 16.0)
//            .width(constant: 142)
//            .height(constant: 60)
//            .fillColor(.purple)
//            .position(.right)
        
    }
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "fractionCompleted" {
            let progress = bundleRequest!.progress.fractionCompleted
            print("~~~~~:\(progress)")
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    @IBAction func updatePosition(_ sender: Any) {
        
//        width.constant = 172
//        left.constant = 120
//        UIView.animate(withDuration: 0.8) {
//            self.item.layoutIfNeeded()
//        }
//        UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear) {
//            self.item.layoutIfNeeded()
//        } completion: { _ in
//
//        }

    }
    
    @IBAction func download(_ sender: Any) {
        
        // https://www.moji365.com/mojiFont/
        
        downloadResources(tags: Set.init(arrayLiteral: "Fangsong"), resources: ["STFANGSO.ttf"])
        
    }
    
    @IBAction func songti(_ sender: Any) {
        downloadResources(tags: Set.init(arrayLiteral: "Songti"), resources: ["Songti.ttc"])
    }
    
    @IBAction func yapi(_ sender: Any) {
        downloadResources(tags: Set.init(arrayLiteral: "Yuppy"), resources: ["YuppySC-Regular.otf"])
    }
    
    @IBAction func heiti(_ sender: Any) {
        
        downloadResources(tags: Set.init(arrayLiteral: "Heiti"), resources: ["STHeiti-Medium.ttc", "STHeiti-Light.ttc"])
    }
    
    func downloadResources(tags: Set<String>, resources: [String]) {
        
        self.bundleRequest = NSBundleResourceRequest(tags: tags)
        
        self.bundleRequest?.loadingPriority = NSBundleResourceRequestLoadingPriorityUrgent
            
        bundleRequest?.conditionallyBeginAccessingResources(completionHandler: { exit in
            
            if exit {
                for name in resources {
                    print("font exit: \(String(describing: Bundle.main.path(forResource: name, ofType: nil)))")
                }
                
                self.bundleRequest?.endAccessingResources()
            } else {
                self.bundleRequest?.progress.addObserver(self, forKeyPath: "fractionCompleted", options: [.new, .initial], context: nil)
                self.bundleRequest?.beginAccessingResources(completionHandler: { error in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.bundleRequest?.endAccessingResources()
                        return
                    }
                    for name in resources {
                        print("downloaded:>>>>>> path: \(String(describing: Bundle.main.path(forResource: name, ofType: nil)))")
                    }
                    
                    self.bundleRequest?.endAccessingResources()
                })
            }
        })
    }
}

