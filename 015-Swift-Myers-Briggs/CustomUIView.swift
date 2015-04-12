//
//  CustomUIView.swift
//  015-Swift-Myers-Briggs
//
//  Created by Audrey Li on 4/11/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit


@IBDesignable
class CustomUIView: UIView {
    
    // assume that the number of choices will always be the same. Otherwise we'll add or remove button each time the data is updated
    var data: QuestionItem! {
        willSet {
            let newData = newValue.options
            for var i = 0; i < newData.count ; i++ {
                optionButtons[i].setTitle(newData[i], forState: .Normal)
                setNeedsDisplay()
            }
 
        }
    }
    var optionButtons: [UIButton] = []
    
    weak var delegate: QuestionChoiceDelegate!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    
    
    override func layoutSubviews() {
    }

    init (frame: CGRect, data question: QuestionItem) {
        super.init(frame: frame)
        self.data = question
        addButtons()
    }
  
    
    func addButtons(){
        for var i = 0 ; i < data.options.count; i++ {
            var btnFrame: CGRect
            if i.isEven(){
               btnFrame = CGRectMake(0, 0, bounds.width , bounds.height / 2 - 5)
            } else {
               btnFrame =  CGRectMake(0, bounds.height / 2 + 5  , bounds.width , bounds.height / 2 - 5)
            }
            
            let btn1 = UIButton.buttonWithType(.System) as UIButton
            btn1.frame = btnFrame
            btn1.backgroundColor =  MDColors.light_blue.P50
            btn1.setTitle(data.options[i], forState: .Normal)
            btn1.addTarget(self, action: "btnTappedAction:", forControlEvents: .TouchUpInside)
            self.addSubview(btn1)
    
            optionButtons.append(btn1)

            
            // allow multiple line and font
            btn1.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            btn1.titleLabel?.textAlignment = NSTextAlignment.Left
            btn1.titleLabel?.font = UIFont(name: "AxureHandwriting", size: 30)
            btn1.titleLabel?.textColor = MDColors.grey.WP1000
            btn1.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        }
        
        
    }
    
    func btnTappedAction(sender: UIButton!) {
        
        if let index = optionButtons.indexOf(sender){
            data.choice = index
            delegate.dataPicker(self, didPickData: data )

        }
        
    }

}
