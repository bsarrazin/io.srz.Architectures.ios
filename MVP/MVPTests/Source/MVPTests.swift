@testable import MVP
import XCTest

class MVPTests: XCTestCase {
    
    func testPresenter() {
        
        class TestView: View {
            var textField: UITextField = .init()
            var textFieldValue: String {
                get { return textField.text ?? "" }
                set { textField.text = newValue }
            }
        }
        
        let model = Model(value: "test value")
        let view = TestView()
        let presenter = Presenter(model: model, view: view)
        XCTAssertTrue(view.textField.text == "test value")
        
        view.textField.text = "new test value"
        presenter.commit()
        
        XCTAssertTrue(presenter.model.value == "new test value")
        XCTAssertTrue(view.textFieldValue == "new test value")
    }
    
    
    func testViewController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        let model = Model(value: "")
        let presenter = Presenter(model: model, view: viewController)
        viewController.presenter = presenter
        
        viewController.beginAppearanceTransition(true, animated: false)
        // We change the value here because we need `viewDidLoad` to have been called
        // in order for the outlets to be set
        presenter.view?.textFieldValue = "test value"
        
        XCTAssertTrue(viewController.textField.text == "test value")
        XCTAssertTrue(viewController.label.text == "test value")
        
        viewController.textField.text = "new test value"
        presenter.commit()
        XCTAssertTrue(viewController.label.text == "new test value")
    }
}
