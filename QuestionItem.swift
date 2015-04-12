//
//  QuestionItem.swift
//  015-Swift-Myers-Briggs
//
//  Created by Audrey Li on 4/11/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

class QuestionItem{
    var question: String!
    var options: [String]
    var optionValues: [PersonalityType]!
    var choice: Int!
    
    init(options:[String], question: String?){
        self.options = options
        self.question = question
    }
    
    func getType() -> PersonalityType? {
        if choice != nil  {
            return optionValues[choice!]
        } else {
            return nil
        }
    }
    
}