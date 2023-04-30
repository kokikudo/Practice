//
//  ModelError.swift
//  Practice
//
//  Created by kudo koki on 2023/04/30.
//

import Foundation

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

extension ModelError {
    var errorText: String {
        switch self {
        case .invalidIdAndPassword: return "IDとPasswordが未入力です。"
        case .invalidId: return "IDが未入力です。"
        case .invalidPassword: return "Passwordが未入力です。"
        }
    }
}
