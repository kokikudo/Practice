//
//  ExpandableTableViewController.swift
//  Practice
//
//  Created by kudo koki on 2023/04/02.
//

import UIKit

class ExpandableTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var indexSet: IndexSet = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(ExpandableHeaderView.nib, forHeaderFooterViewReuseIdentifier: ExpandableHeaderView.reuseIdentifier)
        tableView.register(ExpandableTableViewCell1.nib, forCellReuseIdentifier: ExpandableTableViewCell1.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func addOrRemoveIndexPath(_ indexPath: IndexPath) {
        if indexSet.contains(indexPath.section) {
            indexSet.remove(indexPath.section)
        } else {
            indexSet.insert(indexPath.section)
        }
    }
    
    private func getIsIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexSet.contains(indexPath.section)
    }
    
}

extension ExpandableTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
       guard let view = tableView.dequeueReusableHeaderFooterView(
        withIdentifier: ExpandableHeaderView.reuseIdentifier) as? ExpandableHeaderView else {
           fatalError()
       }
        
        guard let type = ExpandableType(rawValue: section) else {
            fatalError()
        }
        view.setData(type: type)
       return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        addOrRemoveIndexPath(indexPath)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension ExpandableTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ExpandableType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let isOpened = getIsIndexPath(indexPath)
//        switch indexPath {
//        case ExpandableType.cycle.indexPath: return isOpened ? 300 : 100
//        default: return 100
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case ExpandableType.cycle.indexPath:
            return createCycleCell()
        case ExpandableType.shopping.indexPath:
            return UITableViewCell()
        case ExpandableType.videogame.indexPath:
            return UITableViewCell()
        case ExpandableType.warking.indexPath:
            return UITableViewCell()
        case ExpandableType.onsen.indexPath:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    private func createCycleCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpandableTableViewCell1.reuseIdentifier) else { return UITableViewCell() }
        
        return cell
    }
}
