import UIKit

// View Controller -> Presenter -> UseCase
// View Controller <weak< Presenter <weak< UseCase

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private(set) var textField: UITextField!
    @IBOutlet private(set) var button: UIButton!
    @IBOutlet private(set) var label: UILabel!
    
    // MARK: - Properties
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = Model(value: "Initial Clean Value")
        let useCase = UseCase(model: model)
        presenter = DefaultPresenter(useCase: useCase)
        presenter.view = self
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        presenter.commit()
    }
    
}

extension ViewController: View {
    var value: String {
        get { return textField.text ?? "" }
        set { label.text = newValue }
    }
}
