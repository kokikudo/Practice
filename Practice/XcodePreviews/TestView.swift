import UIKit
import SwiftUI
import SnapKit

final class TestView: UIView, InputAppliable {
    enum Input {
        case setLabeTitle(title: String)
        case setButtonTitle(title: String)
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, button])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
    
    // Preview側で設定したInputを元にUI更新
    func apply(input: Input) {
        switch input {
        case .setButtonTitle(let title):
            button.setTitle(title, for: .normal)
        case .setLabeTitle(let title):
            titleLabel.text = title
        }
    }
}

