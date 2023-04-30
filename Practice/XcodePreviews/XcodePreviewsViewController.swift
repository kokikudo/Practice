//
//  XcodePreviewsViewController.swift
//  Practice
//
//  Created by kudo koki on 2023/04/08.
//
import UIKit

class XcodePreviewsViewController: UIViewController, InputAppliable {
    func apply(input: Input) {
        switch input {
        case .setData(let items):
            textView.updateViews(items)
        }
    }
    
    @IBOutlet weak var textView: TestViewFromXib!
    
    enum Input {
        case setData(items: [String])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

import SwiftUI

struct Wrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = XcodePreviewsViewController
    
    
    let inputs: [UIViewControllerType.Input]
    init(inputs: [UIViewControllerType.Input]) {
        self.inputs = inputs
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        
        let storyboard = UIStoryboard(name: "XcodePreviews", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(identifier: "XcodePreviewsViewController")
        return vc as! Wrapper.UIViewControllerType
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.apply(inputs: inputs)
    }
}

struct XPVCPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            
            Wrapper(inputs: [
                .setData(items: ["koki", "nathumi", "kazuhiro", "horie", "hiroyuki", "jun", "seno", "shun", "ryuse", "koki", "nathumi", "kazuhiro", "horie", "hiroyuki", "jun", "seno", "shun", "ryuse"])
            ])
            .previewDisplayName("test")
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
            
            Wrapper(inputs: [
                .setData(items: ["koki", "nathumi", "kazuhiro", "horie", "hiroyuki", "jun", "seno", "shun", "ryuse", "koki", "nathumi", "kazuhiro", "horie", "hiroyuki", "jun", "seno", "shun", "ryuse"])
            ])
            .previewDisplayName("test2")
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        }
    }
    
    static var platform: PreviewPlatform? = .iOS
}
