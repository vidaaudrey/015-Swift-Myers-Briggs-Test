//
//  ResultCustomView.swift
//  015-Swift-Myers-Briggs
//
//  Created by Audrey Li on 4/11/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class ResultCustomView: UIView {

    var view: UIView!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeInfoLabel: UILabel!
    var doneHandler:((Bool) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "ResultCustomView", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as UIView
        return view
    }
    @IBAction func tryAgainButtonPressed(sender: UIButton) {
        doneHandler?(true)
        
    }

    @IBAction func infoButtonPressed(sender: UIButton) {
        doneHandler?(false)
    }
}
