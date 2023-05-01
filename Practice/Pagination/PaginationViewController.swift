//
//  PaginationViewController.swift
//  Practice
//
//  Created by kudo koki on 2023/04/29.
//

import UIKit
import RxCocoa
import RxSwift

class PaginationViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    private lazy var viewSpinner: UIView = {
            let view = UIView(frame: CGRect(
                                x: 0,
                                y: 0,
                                width: view.frame.size.width,
                                height: 100)
            )
            let spinner = UIActivityIndicatorView()
            spinner.center = view.center
            view.addSubview(spinner)
            spinner.startAnimating()
            return view
        }()
    private lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            return refreshControl
        }()
    private var viewModel: PaginationViewModel?
    private let disposeBag = DisposeBag()
    private let scrollEndSubject = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupTableView()
        bind()
    }

    private func bind() {
        viewModel?.items.bind(to: tableView.rx.items) { tableView, _, item in
            let cell = tableView
                .dequeueReusableCell(withIdentifier: UITableViewCell.description())
            cell?.selectionStyle = .none
            cell?.textLabel?.text = item
            return cell ?? UITableViewCell()
        }
        .disposed(by: disposeBag)
        
        viewModel?.refreshComplietedEvent.subscribe { [weak self] _ in
            self?.refreshControl.endRefreshing()
        }
        .disposed(by: disposeBag)
        
        tableView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offsetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height
            let frameSizeHeight = self.tableView.frame.size.height
            
            if offsetY > (contentHeight - frameSizeHeight - 100) {
                self.scrollEndSubject.onNext(())
            }
        }
        .disposed(by: disposeBag)
        
        viewModel?.isLoadingEvent.subscribe { [weak self] isLoading in
            self?.tableView.tableFooterView = isLoading ? self?.viewSpinner : UIView(frame: .zero)
        }
        .disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        let selectTab = Observable.merge(
            oneButton.rx.tap.map{ _ in PaginationHeaderType.one },
            twoButton.rx.tap.map{ _ in PaginationHeaderType.two },
            threeButton.rx.tap.map{ _ in PaginationHeaderType.three }
        ).startWith(.one)
        
        let input = PaginationViewModelInput(
            selectTab: selectTab,
            scrollEnd: scrollEndSubject.startWith(()),
            refresh: refreshControl.rx.controlEvent(.valueChanged).asObservable()
        )
        
        viewModel = PaginationViewModel(
            selectTab: selectTab,
            scrollEnd: scrollEndSubject.startWith(()),
            refresh: refreshControl.rx.controlEvent(.valueChanged).asObservable(),
            model: NewModel(selectedType: .one)
        )
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: UITableViewCell.description())
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
    }
}

extension PaginationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
}
