import RxCocoa
import RxSwift
import UIKit

enum Pattern {
    case procedural
    case reactive
}

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private(set) var textField: UITextField!
    @IBOutlet private(set) var button: UIButton!
    @IBOutlet private(set) var label: UILabel!
    
    // MARK: - Properties
    let pattern: Pattern = .reactive
    var procViewModel: ProcViewModel!
    var procObserver: NSObjectProtocol!
    
    let bag = DisposeBag()
    var rxViewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch pattern {
        case .procedural: procViewDidLoad()
        case .reactive: rxViewDidLoad()
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch pattern {
        case .procedural: procButtonTapped(sender)
        case .reactive: break
        }
    }
    
}

// MARK: - Procedural
extension ViewController {
    
    func procViewDidLoad() {
        procViewModel = ProcViewModel(model: Model(value: "Inital Proc Value"))
        textField.text = procViewModel.model.value
        procObserver = procViewModel.observe(\.value, options: [.initial, .new], changeHandler: { [unowned self] viewModel, change in
            self.label.text = change.newValue ?? ""
        })
    }
    
    func procButtonTapped(_ sender: UIButton) {
        procViewModel.commit(value: textField.text ?? "")
    }
    
}

// MARK: - Reactive
extension ViewController {
    
    func rxViewDidLoad() {
        let model = Model(value: "Initial RX Value")
        rxViewModel = ViewModel(model: model)
        
        rxViewModel.value
            .drive(self.label.rx.text)
            .disposed(by: bag)
        
        rxViewModel.value
            .drive(self.textField.rx.text)
            .disposed(by: bag)
        
        button.rx.tap
            .map { [textField] in textField?.text ?? "" }
            .subscribe(rxViewModel.commit)
            .disposed(by: bag)
    }
    
}
