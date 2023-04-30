//
//  PaginationViewModel.swift
//  Practice
//
//  Created by kudo koki on 2023/04/29.
//
import UIKit
import RxSwift
import RxCocoa

struct PaginationViewModelInput {
    let selectTab: Observable<PaginationHeaderType>
    let scrollEnd: Observable<()>
    let refresh: Observable<()>
}

protocol PaginationViewModelOutput {
    var items: Observable<[String]> { get }
    var refreshComplietedEvent: Observable<Void> { get }
    var isLoadingEvent: Observable<Bool> { get }
}

protocol PaginationViewModelType {
    var output: PaginationViewModelOutput { get }
    func setup(input: PaginationViewModelInput)
}

class PaginationViewModel: PaginationViewModelType {
    var output: PaginationViewModelOutput { return self }
    
    private let disposeBag = DisposeBag()
    private let dummyService = PaginationDummyService()
        
    private let itemsSubject = PublishSubject<[String]>()
    private let oneItems = BehaviorRelay<[String]>(value: [])
    private let twoItems = BehaviorRelay<[String]>(value: [])
    private let threeItems = BehaviorRelay<[String]>(value: [])
    private var onePageCount = 0
    private var twoPageCount = 0
    private var threePageCount = 0
    private var isLoadingNextPage = BehaviorRelay<Bool>(value: false)
    private let refreshComplietedSubject = PublishSubject<Void>()
    
    func setup(input: PaginationViewModelInput) {
        
        
        input.refresh
            .withLatestFrom(input.selectTab)
            .bind(onNext: actionRefresh)
            .disposed(by: disposeBag)
        
        input.scrollEnd
            .withLatestFrom(input.selectTab)
            .map { self.getSelectedTypeAndPage(type: $0) }
            .bind(onNext: addFetch)
            .disposed(by: disposeBag)
        
        let displayedItems = Observable.merge(
            oneItems.asObservable(), twoItems.asObservable(), threeItems.asObservable()
        )
        
        Observable.combineLatest(displayedItems, input.selectTab)
            .map { self.changeDisplayItems(type: $1) }
            .bind(to: itemsSubject)
            .disposed(by: disposeBag)
        
        
        if onePageCount == 0, twoPageCount == 0, threePageCount == 0 {
            firstFetch()
        }
    }
    
    private func getSelectedTypeAndPage(type: PaginationHeaderType) -> (PaginationHeaderType, Int, (() -> Void)?) {
        switch type {
        case .one: return (.one, onePageCount, nil)
        case .two: return (.two, twoPageCount, nil)
        case .three: return (.three, threePageCount, nil)
        }
    }
    
    private func addFetch(type: PaginationHeaderType, page: Int, refreshCompletion: (() -> Void)? = nil) {
        if isLoadingNextPage.value { return }
        isLoadingNextPage.accept(true)
        dummyService.fetchDatas(type: type, page: page) { data in
            if let items = data.datas {
                self.addDatas(type: type, datas: items)
                refreshCompletion?()
            }
            self.isLoadingNextPage.accept(false)
        }
    }
    
    private func actionRefresh(type: PaginationHeaderType) {
        removeItems(type: type)
        var page: Int {
            switch type {
            case .one: return onePageCount
            case .two: return twoPageCount
            case .three: return threePageCount
            }
        }
        addFetch(type: type, page: page) {
            self.refreshComplietedSubject.onNext(())
        }
    }
    
    private func removeItems(type: PaginationHeaderType) {
        switch type {
        case .one:
            oneItems.accept([])
            onePageCount = 0
        case .two:
            twoItems.accept([])
            twoPageCount = 0
        case .three:
            threeItems.accept([])
            threePageCount = 0
        }
    }
    
    private func firstFetch() {
        dummyService.fetchDatas(type: .one, page: onePageCount) { data in
            if let items = data.datas {
                self.addDatas(type: .one, datas: items)
            }
        }
        
        dummyService.fetchDatas(type: .two, page: twoPageCount) { data in
            if let items = data.datas {
                self.addDatas(type: .two, datas: items)
            }
        }
        
        dummyService.fetchDatas(type: .three, page: threePageCount) { data in
            if let items = data.datas {
                self.addDatas(type: .three, datas: items)
            }
        }
    }
    
    private func changeDisplayItems(type: PaginationHeaderType) -> [String] {
        switch type {
        case .one: return self.oneItems.value
        case .two: return self.twoItems.value
        case .three: return self.threeItems.value
        }
    }
    
    private func addDatas(type: PaginationHeaderType, datas: [String]) {
        switch type {
        case .one:
            if onePageCount == 1 {
                oneItems.accept(datas)
            } else {
                let oldDatas = oneItems.value
                oneItems.accept(oldDatas + datas)
            }
            onePageCount += 1
        case .two:
            if twoPageCount == 1 {
                twoItems.accept(datas)
            } else {
                let oldDatas = twoItems.value
                twoItems.accept(oldDatas + datas)
            }
            twoPageCount += 1
        case .three:
            if threePageCount == 1 {
                threeItems.accept(datas)
            } else {
                let oldDatas = threeItems.value
                threeItems.accept(oldDatas + datas)
            }
            threePageCount += 1
        }
    }
}

extension PaginationViewModel: PaginationViewModelOutput {
    var isLoadingEvent: RxSwift.Observable<Bool> {
        return isLoadingNextPage.asObservable()
    }
    
    var refreshComplietedEvent: RxSwift.Observable<Void> {
        return refreshComplietedSubject
    }
    
    var items: RxSwift.Observable<[String]> {
        return itemsSubject
    }
}
