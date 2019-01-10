import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private(set) var textField: UITextField!
    @IBOutlet private(set) var button: UIButton!
    @IBOutlet private(set) var label: UILabel!
    
    // MARK: - Properties
    var model: Model!
    var viewState: ViewState!
    var vsObserver: NSObjectProtocol!
    var modelObserver: NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = Model(value: "Initial ViewState Value")
        
        label.text = model.value
        textField.text = model.value
        
        viewState = ViewState(value: model.value)
        vsObserver = NotificationCenter.default
            .addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: nil,
                using: { [viewState] notification in
                    let textField = notification.object as! UITextField
                    viewState?.value = textField.text ?? ""
                })
        
        modelObserver = NotificationCenter.default
            .addObserver(
                forName: Model.valueDidChangeNotification,
                object: nil,
                queue: nil,
                using: { [label] notification in
                    label?.text = notification.userInfo?[Model.valueDidChangeUserInfoKey] as? String
                })
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        model.value = viewState.value
    }
    
}
