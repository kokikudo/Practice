//
//  PaginationHeaderType.swift
//  Practice
//
//  Created by kudo koki on 2023/04/29.
//

import Foundation

enum PaginationHeaderType: Int {
    case one = 1
    case two
    case three
    
    var dummyDatas: [String] {
        switch self {
        case .one: return ["a","b","c","d","e","f","g"]
        case .two: return ["A","B","C","D","E","F","G"]
        case .three: return ["1","2","3","4","5","6","7"]
        }
    }
}
