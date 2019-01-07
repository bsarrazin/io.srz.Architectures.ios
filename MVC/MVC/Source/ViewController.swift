import UIKit

enum Pattern {
    case observable
    case nonObservable
}

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private(set) var textField: UITextField!
    @IBOutlet private(set) var button: UIButton!
    @IBOutlet private(set) var label: UILabel!
    
    // MARK: - Properties
    var model: Model = .init(value: "Initial Value")
    private let pattern: Pattern = .nonObservable
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch pattern {
        case .observable: observableViewDidLoad()
        case .nonObservable: nonObservableViewDidLoad()
        }
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        switch pattern {
        case .observable: observableButtonTapped()
        case .nonObservable: nonObservableButtonTapped()
        }
    }
    
}

// MARK: - Non Observable Pattern
extension ViewController {
    
    func nonObservableViewDidLoad() {
        textField.text = model.value
        label.text = model.value
    }
    
    func nonObservableButtonTapped() {
        model.value = textField.text ?? ""
        label.text = model.value
    }
    
}

// MARK: - Observable Pattern
extension ViewController {
    
    func observableViewDidLoad() {
        textField.text = model.value
        label.text = model.value
        
        NotificationCenter.default
            .addObserver(
                forName: Model.valueDidChangeNotification,
                object: nil,
                queue: nil,
                using: { [label] notification in
                    let value = notification.userInfo?[Model.valueDidChangeUserInfoKey] as? String ?? ""
                    label?.text = value
                })
    }
    
    func observableButtonTapped() {
        model.value = textField.text ?? ""
    }
    
}
