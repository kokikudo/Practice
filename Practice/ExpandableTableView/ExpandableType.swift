//
//  ExpandableType.swift
//  Practice
//
//  Created by kudo koki on 2023/04/02.
//

import Foundation

enum ExpandableType: Int, CaseIterable {
    case cycle = 0
    case shopping
    case videogame
    case warking
    case onsen
    
    var title: String {
        switch self {
        case .cycle:
            return "cycle"
        case .shopping:
            return "shopping"
        case .videogame:
            return "videogame"
        case .warking:
            return "warking"
        case .onsen:
            return "onsen"
        }
    }
    
    var indexPath: IndexPath {
        switch self {
        case .cycle: return [0, 0]
        case .shopping: return [1, 0]
        case .videogame:  return [2, 0]
        case .warking: return [3, 0]
        case .onsen: return [4, 0]
        }
    }
}
