//
//  PreviewContainerViewController.swift
//  Practice
//
//  Created by kudo koki on 2023/04/08.
//

import UIKit
import SnapKit

class PreviewContainerViewController<Child: UIViewController>: UIViewController {
    
    enum Position {
        case top
        case left
        case right
        case bottom
        case center
    }
    
    let child: Child
    let position: Position
    
    init(child: Child, position: Position = .center) {
        self.child = child
        self.position = position
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
        
        switch position {
        case .top:
            child.view.snp.makeConstraints {
                $0.edges.top.equalToSuperview()
                $0.edges.leading.equalToSuperview()
                $0.edges.trailing.equalToSuperview()
            }
        case .left:
            child.view.snp.makeConstraints {
                $0.edges.top.equalToSuperview()
                $0.edges.leading.equalToSuperview()
                $0.edges.bottom.equalToSuperview()
            }
        case .right:
            child.view.snp.makeConstraints {
                $0.edges.top.equalToSuperview()
                $0.edges.bottom.equalToSuperview()
                $0.edges.trailing.equalToSuperview()
            }
        case .bottom:
            child.view.snp.makeConstraints {
                $0.edges.bottom.equalToSuperview()
                $0.edges.leading.equalToSuperview()
                $0.edges.trailing.equalToSuperview()
            }
        case .center:
            child.view.snp.makeConstraints {
                $0.edges.centerX.equalToSuperview()
                $0.edges.centerY.equalToSuperview()
            }
        }
    }
    
}
