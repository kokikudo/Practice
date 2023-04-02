import RxSwift
import RxCocoa
import UIKit
import RangeSeekSlider

class SliderAndTextFieldViewController: UIViewController {
    
    @IBOutlet weak var rangeSeekSlider: CustomRangeSeekSlider!
    
    @IBOutlet weak var minTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    
    private let disposeBag = DisposeBag()
        
    static var defaultRange: (min: Double, max: Double) = {
        let prices: [Double] = [
            500, 1_000, 2_000, 3_000, 4_000, 5_000, 6_000, 7_000, 8_000, 9_000,
            10_000, 11_000, 12_000, 13_000, 14_000, 15_000, 16_000, 17_000, 18_000, 19_000,
            20_000, 21_000, 22_000, 23_000, 24_000, 25_000, 26_000, 27_000, 28_000, 29_000,
            30_000, 31_000, 32_000, 33_000, 34_000, 35_000, 36_000, 37_000, 38_000, 39_000,
            40_000, 41_000, 42_000, 43_000, 44_000, 45_000, 46_000, 47_000, 48_000, 49_000,
            50_000, 55_000, 60_000, 65_000, 70_000, 75_000, 80_000, 85_000, 90_000, 95_000,
            100_000, 110_000, 120_000, 130_000, 140_000, 150_000
        ]
        return (prices.first ?? 0.0 , prices.last ?? 0.0)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewModel()
        
        ///エリア外タップでTextFieldを戻す
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
    
    private func setViewModel() {
        let viewModel = SliderAndTextFieldViewModel(
            input: (
                sliderRange: rangeSeekSlider.changeRangeSeekSliderEvent,
                minText: minTextField.rx.controlEvent(.editingDidEnd)
                    .withLatestFrom(minTextField.rx.text.orEmpty)
                    .asDriver(onErrorJustReturn: ""),
                maxText: maxTextField.rx.controlEvent(.editingDidEnd)
                    .withLatestFrom(maxTextField.rx.text.orEmpty)
                    .asDriver(onErrorJustReturn: "")
            )
        )
        viewModel.newRange.drive(onNext: changeRangeCompletion).disposed(by: disposeBag)
    }
    
    private func changeRangeCompletion(_ output: SliderAndTextFieldViewModel.Range) {
        switch output.inputType {
        case .TextField: updateSlider(output)
        case .Slider: updateTextField(output)
        }
    }
    
    private func updateTextField(_ output: SliderAndTextFieldViewModel.Range) {
        print("updateTextField: \(output.min), \(output.max)")
        minTextField.text = Int(output.min).description
        maxTextField.text = Int(output.max).description
    }
    
    private func updateSlider(_ output: SliderAndTextFieldViewModel.Range) {
        print("updateSlider: \(output.min), \(output.max)")
        rangeSeekSlider.updateRange(output)
    }
}

extension String {
    var stringDouble: Double {
        return Double(self) ?? 0
    }
}
