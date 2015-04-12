//
//  MyersTest.swift
//  015-Swift-Myers-Briggs
//
//  Created by Audrey Li on 4/11/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

class MyersTest {
    var eValue = 0 , iValue = 0 , sValue = 0, nValue = 0, tValue = 0, fValue = 0, jValue = 0, pValue = 0
    
    var questions: [QuestionItem]?
    
    init(questions: [QuestionItem]) {
        self.questions = questions
        
    }
    
    func getType() -> String{
        
        var eValue = 0 , iValue = 0 , sValue = 0, nValue = 0, tValue = 0, fValue = 0, jValue = 0, pValue = 0
        
        for var i = 0; i < questions!.count; i++ {
            
            if let questionItemType = questions?[i].getType() {
                switch questionItemType {
                case .Extraversion: eValue += 1
                case .Introversion: iValue += 1
                case .Sensing: sValue += 1
                case .Intuition: nValue += 1
                case .Thinking: tValue += 1
                case .Feeling: fValue += 1
                case .Judgement: jValue += 1
                case .Perception: pValue += 1
                }
            }
        }

        var arr:[PersonalityType] = []
        let eiType = eValue > iValue ? PersonalityType.Extraversion : PersonalityType.Introversion
        let snType = sValue > nValue ? PersonalityType.Sensing : PersonalityType.Intuition
        let tfType = tValue > fValue ? PersonalityType.Thinking : PersonalityType.Feeling
        let jpType = jValue > pValue ? PersonalityType.Judgement : PersonalityType.Perception
        
        let typeString = "\(eiType.rawValue)" + "\(snType.rawValue)" + "\(tfType.rawValue)" + "\(jpType.rawValue)"
    
        return typeString
    }

}