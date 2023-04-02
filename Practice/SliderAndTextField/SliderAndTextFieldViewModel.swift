import RxSwift
import RxCocoa
import UIKit
import RangeSeekSlider

class SliderAndTextFieldViewModel {
    typealias Range = (min: Double, max: Double, inputType: InputType)
    
    private let defaultRange = SliderAndTextFieldViewController.defaultRange
        
    private let minRelay = PublishRelay<Double>()
    private let maxRelay = PublishRelay<Double>()
    
    let newRange: Driver<Range>
    
    private let minValue: Driver<Double>
    private let maxValue: Driver<Double>
    private let inputType: Driver<InputType>
    
    init(
        input: (
            sliderRange: Driver<Range>,
            minText: Driver<String>,
            maxText: Driver<String>
        )
    ) {
        minValue = Driver.merge(
            input.minText.map { $0.stringDouble },
            input.sliderRange.map { $0.min }
        ).startWith(defaultRange.min)
        
        maxValue = Driver.merge(
            input.maxText.map { $0.stringDouble },
            input.sliderRange.map { $0.max }
        ).startWith(defaultRange.max)
        
        inputType = Driver.merge(
            input.minText.map { _ in .TextField },
            input.maxText.map { _ in .TextField },
            input.sliderRange.map { _ in .Slider }
        ).startWith(.TextField)
        
        newRange = Driver.combineLatest(
            minValue, maxValue, inputType
        ).flatMap({ (min, max, type) in
            .just(Range(min, max, type))
        })
    }
}

enum InputType {
    case TextField, Slider
}
