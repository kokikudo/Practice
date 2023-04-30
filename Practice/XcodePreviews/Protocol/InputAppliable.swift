//
//  InputAppliable.swift
//  Practice
//
//  Created by kudo koki on 2023/04/08.
//

import Foundation

protocol InputAppliable {
    associatedtype Input
    func apply(input: Input)
}

extension InputAppliable {
    func apply(inputs: [Input]) {
        for input in inputs {
            self.apply(input: input)
        }
    }
}
