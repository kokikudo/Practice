import SwiftUI
import Foundation

struct TsetContents {
    static let items = ["koki", "nathumi", "kazuhiro", "horie", "hiroyuki", "jun", "seno", "shun", "ryuse"]
}

struct TextViewFromXibPreview: PreviewProvider {
    
    // UIkitで作ったViewをSwiftUI専用Viewに変換
    struct Wrapper: UIViewRepresentable {
        let inputs: [TestViewFromXib.Input]
        init(inputs: [TestViewFromXib.Input]) {
            self.inputs = inputs
        }
        
        func makeUIView(context: Context) -> TestViewFromXib {
            let view = TestViewFromXib()
            view.apply(inputs: inputs)
            return view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) {
            uiView.apply(inputs: inputs)
        }
    }
    
    static var previews: some View {
        Group {
                Wrapper(
                    inputs: [
                        .setItems(items: ["koki", "nathumi", "kazuhiro", "horie", "hiroyuki", "jun", "seno", "shun", "ryuse"])
                    ]
                )
                .previewDisplayName("test1")
                .previewLayout(.fixed(width: 300, height: 100))
            
        }
    }
    
    static var platform: PreviewPlatform? = .iOS
}
