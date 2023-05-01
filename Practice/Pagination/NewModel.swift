//
//  NewModel.swift
//  Practice
//
//  Created by kudo koki on 2023/05/01.
//

import Foundation
import RxSwift

class ItemsModel {
    var items: [String] = []
    var pageCount: Int = 0
}

protocol NewModelProtocol {
    var selectedType: PaginationHeaderType { get }
    var allItemsModel: ItemsModel { get set }
    var ownedItemsModel: ItemsModel { get set }
    var watchItemsModel: ItemsModel { get set }
    func fetchDatas(type: PaginationHeaderType) -> Observable<PaginationDummyServiceData?>
}

final class NewModel: NewModelProtocol {
    var selectedType: PaginationHeaderType = .one
    
    var allItemsModel = ItemsModel()
    
    var ownedItemsModel = ItemsModel()
    
    var watchItemsModel = ItemsModel()
    
    
    var maxPage = 5
    
    init(selectedType: PaginationHeaderType) {
        self.selectedType = selectedType
    }
    
    func fetchDatas(type: PaginationHeaderType) -> Observable<PaginationDummyServiceData?> {
        selectedType = type
        
        
        var data: PaginationDummyServiceData?
        
        sleep(3)
        
        data = PaginationDummyServiceData(
            maxPage: self.maxPage,
            hasMore: true,
            datas: self.selectedType.dummyDatas
        )
        
        guard let safeData = data else {
            return Observable.just(nil)
        }
        
        updateItem(data: safeData)
        
        return Observable.just(safeData)
    }
    
    private func updateItem(data: PaginationDummyServiceData) {
        switch selectedType {
        case .one:
            allItemsModel.items = allItemsModel.items + data.datas!
            allItemsModel.pageCount += 1
        case .two:
            ownedItemsModel.items = ownedItemsModel.items + data.datas!
            ownedItemsModel.pageCount += 1
        case .three:
            watchItemsModel.items = watchItemsModel.items + data.datas!
            watchItemsModel.pageCount += 1
        }
    }
}
