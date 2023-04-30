//
//  ViewController.swift
//  Practice
//
//  Created by kudo koki on 2023/04/01.
//

import UIKit
import SwiftUI
import SnapKit

class ViewController: UIViewController {

    lazy private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(actionButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
    }

    private func setButton() {
        view.addSubview(button)
        
        button.snp.makeConstraints { $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func actionButtonTap() {
        if button.backgroundColor == .blue {
            button.backgroundColor = .red
        } else {
            button.backgroundColor = .blue
        }
    }
}

struct ViewControllerPreview: PreviewProvider {
    struct Wrapper: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            ViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
