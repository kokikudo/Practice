//
//  PaginationDummyService.swift
//  Practice
//
//  Created by kudo koki on 2023/04/29.
//

import Foundation

struct PaginationDummyServiceData {
    let maxPage: Int
    let hasMore: Bool
    let datas: [String]?
}

struct PaginationDummyService {
    private let maxPage = 5
    
    func fetchDatas(type: PaginationHeaderType, page: Int, completion: @escaping (PaginationDummyServiceData) -> ()) {
        if page > maxPage {
            DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                completion(PaginationDummyServiceData(maxPage: maxPage,
                                                      hasMore: false,
                                                      datas: nil))
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()+5) {
                completion(PaginationDummyServiceData(maxPage: maxPage,
                                                      hasMore: page != maxPage,
                                                      datas: type.dummyDatas))
            }
            
        }
    }
}
