//
//  ViewController.swift
//  015-Swift-Myers-Briggs
//
//  Created by Audrey Li on 4/11/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

protocol QuestionChoiceDelegate: class {
    
    // func initalData() -> QuestionItem
    func dataPicker(picker: CustomUIView, didPickData data: QuestionItem )
    
}

class ViewController: UIViewController, QuestionChoiceDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    
    // re-use two views for the UIViewAnimation Transition effect
    var frontView: CustomUIView!
    var backView: CustomUIView!
    
    var questions: [QuestionItem]!
    var indexNumber = 0 // track current question
    var resultView: ResultCustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questions = createTest()
        
        setUpQuestionViews()
    }

    
    func setUpQuestionViews() {
        
        if questions != nil {
            
            let rect = CGRectInset(view.bounds, 10 , 150)
            
            backView = CustomUIView(frame: rect, data: questions[1])
            view.addSubview(backView)
            backView.delegate = self
            
            frontView = CustomUIView(frame: rect, data: questions[0])
            view.addSubview(frontView)
            frontView.delegate = self
            
            resultView = ResultCustomView(frame: rect)
            resultView.doneHandler = { self.didPressTrayAgainButton($0) }
            resultView.alpha = 0
        }
        
    }
    
    //delegate
    func dataPicker(picker: CustomUIView, didPickData data: QuestionItem) {
        self.questionNumberLabel.text =  "Question: \(indexNumber + 1)/\(questions.count)"
        if indexNumber < questions.count - 1 {
            self.questions[indexNumber] = data
            var views = (front: frontView, back: backView)
            if self.frontView.superview != nil {
                views = (front: frontView, back:backView)
                
            } else {
                views = (front: backView, back: frontView)
            }
            
            views.front.data = questions[indexNumber]
            views.back.data = questions[indexNumber + 1]
            
            indexNumber++
            
            view.addSubview(resultView)
            let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
            UIView.transitionFromView(views.front, toView: views.back, duration: 1, options: transitionOptions, completion: nil)
            
            questionNumberLabel.text = "Question: \(indexNumber + 1)/\(questions.count)"
            
        } else {
            
            // finished test, present the result
            
            backView.removeFromSuperview()
            questionNumberLabel.alpha = 0
            
            view.addSubview(resultView)
            
            let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
            
            UIView.transitionFromView(frontView, toView: resultView, duration: 1, options: transitionOptions, completion: { (finished) -> Void in

                self.frontView.removeFromSuperview()
                self.resultView.alpha = 1
                self.title = "Your Personality Type"
                
                var test = MyersTest(questions: self.questions)
                var type = MBTITypes(typeString: test.getType())
                
                self.resultView.typeLabel.text = test.getType()
                self.resultView.typeInfoLabel.text = type?.rawValue
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.resultView.frame = self.view.bounds
                    }, completion: { (finished) -> Void in
                        
                })
            })
            
            
        }
        
    }
    
    func didPressTrayAgainButton(data: Bool){
        if data {
            
            let transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
            indexNumber = 0
            
            UIView.transitionFromView(resultView, toView: frontView, duration: 1, options: transitionOptions, completion: { (finished) -> Void in
                
                self.title = "Myers Briggs Test"
                self.questionNumberLabel.alpha = 1
                self.setUpQuestionViews()
                self.questions = self.createTest()
            })
            
        } else {
            
            // below is to execute when the "info" button is touched
            var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("infoViewController") as UIViewController
            
            let subViews = popoverContent.view.subviews
            if let dismissBtn = popoverContent.view.viewWithTag(1) as? UIButton {
                    dismissBtn.addTarget(self, action: "dismiss:", forControlEvents: .TouchUpInside)
                
            }
          
            var nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            var popover = nav.popoverPresentationController
            popoverContent.preferredContentSize = CGSizeMake(500,600)
            
            self.presentViewController(nav, animated: true, completion: nil)

        }
    }
    
    func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: self)
    }
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController!) -> UIModalPresentationStyle {
        return .None
    }
    
    func createTest() -> [QuestionItem] {
        var testArr:[QuestionItem] = []
        var testOptions: [[String]] = [[]]
        
        let q1 = ["expend energy, enjoy groups", "conserve energy, enjoy one-on-one"]
        let q2 = ["interpret matters literally, rely on common sense", "look for meaning and possibilities, rely on foresign"]
        let q3 = ["a logical, thinking, question", "empathetic, feeling, accommondating"]
        let q4 =  ["organized, orderly", "flexible, adaptable"]
        let q5 = ["more outgoing, think out loud","more reserved, think to yourself"]
        let q6 = ["practical, realistic, experiential", "imaginative, innovative, theoretial"]
        let q7 = ["candid, straight forward, frank", "tactful, kind, encouraging"]
        let q8 = ["plan, schedule","unplanned, spontaneous"]
        let q9 =  ["seek many tasks, public activities, interaction with others","seek more private, solitary activities with quiet to concentrate"]
        let q10 = ["standard,usual, conventional","different, novel, unique"]
        let q11 = ["firm, tend to criticize, hold the line","gental, tend to appreciate, conciliate"]
        let q12 = ["regulated, structured","easygoing, \"live\" and \"let live\""]
        let q13 = ["external, communicative, express yourself", "internal, reticent, keep to yourself"]
        let q14 =  ["consider immediate issues, focus on the here-and-now","look to the future, global perspective, \"big picture\'"]
        let q15 = ["tought-minded, just","tender-hearted, merciful"]
        let q16 = ["preparation, plan ahead","go with the flow, adapt as you go"]
        let q17 = ["active, initiate","reflective, deliberate"]
        let q18 = ["fact, things, seeing\"what is\"", "ideas, dreams, seeing \"what could be\",philosophical"]
        let q19 = ["matter of fact, issue-oriented, principled", "sensitive, people-oriented, commaionate"]
        let q20 =  ["control, govern", "latitude, freedom"]
        
        testOptions.append(q1)
        testOptions.append(q2)
        testOptions.append(q3)
        testOptions.append(q4)
        testOptions.append(q5)
        testOptions.append(q6)
        testOptions.append(q7)
        testOptions.append(q8)
        testOptions.append(q9)
        testOptions.append(q10)
        testOptions.append(q11)
        testOptions.append(q12)
        testOptions.append(q13)
        testOptions.append(q14)
        testOptions.append(q15)
        testOptions.append(q16)
        testOptions.append(q17)
        testOptions.append(q18)
        testOptions.append(q19)
        testOptions.append(q20)
        testOptions.removeAtIndex(0)
        
        
        for var i = 0; i < testOptions.count; i++ {
            let item = QuestionItem(options: testOptions[i], question: nil )
            testArr.append(item)
        }
        
        for item in [testArr[0], testArr[4], testArr[8], testArr[12], testArr[16]] {
            item.optionValues = [PersonalityType.Extraversion, PersonalityType.Introversion]
        }
        
        for item in [testArr[1], testArr[5], testArr[9], testArr[13], testArr[17]] {
            item.optionValues = [PersonalityType.Sensing, PersonalityType.Intuition]
        }
        
        for item in [testArr[2], testArr[6], testArr[10], testArr[14], testArr[18]] {
            item.optionValues = [PersonalityType.Thinking, PersonalityType.Feeling]
        }
        
        for item in [testArr[3], testArr[7], testArr[11], testArr[15], testArr[19]] {
            item.optionValues = [PersonalityType.Judgement, PersonalityType.Perception]
        }
        
      return testArr.shuffled()  // randomize the questions
       // return testArr
        
    }
    
}

