import SwiftUI
import Foundation

struct TestViewPreview: PreviewProvider {
    
    // UIkitで作ったViewをSwiftUI専用Viewに変換
    struct Wrapper: UIViewRepresentable {
        let inputs: [TestView.Input]
        init(inputs: [TestView.Input]) {
            self.inputs = inputs
        }
        
        func makeUIView(context: Context) -> TestView {
            let view = TestView()
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
                        .setLabeTitle(title: "ボタンを押して！"),
                        .setButtonTitle(title: "Button")
                    ]
                )
                .previewDisplayName("test1")
                .previewLayout(.fixed(width: 300, height: 100))
                
                Wrapper(
                    inputs: [
                        .setLabeTitle(title: "Label Title"),
                        .setButtonTitle(title: "ButtonButtonButton")
                    ]
                )
                .previewDisplayName("Long Button Title")
                .previewLayout(.fixed(width: 300, height: 100))
            
        }
    }
    
    static var platform: PreviewPlatform? = .iOS
}
