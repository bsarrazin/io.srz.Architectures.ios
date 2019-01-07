import UIKit

class ViewController: UIViewController, View {
    
    // MARK: - Outlets
    @IBOutlet private(set) var textField: UITextField!
    @IBOutlet private(set) var button: UIButton!
    @IBOutlet private(set) var label: UILabel!
    
    // MARK: - Properties
    lazy var presenter: Presenter = Presenter(model: Model(value: "inital value"), view: self)
    var textFieldValue: String {
        get { return textField?.text ?? "" }
        set {
            textField?.text = newValue
            label?.text = newValue
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        presenter.commit()
    }
    
}
