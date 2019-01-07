@testable import MVC
import XCTest

class MVCTests: XCTestCase {
    
    func testExample() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.model = Model(value: "test value")
        viewController.beginAppearanceTransition(true, animated: false)
        
        XCTAssertTrue(viewController.label.text == "test value")
        XCTAssertTrue(viewController.textField.text == "test value")
        
        viewController.textField.text = "new test value"
        viewController.button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(viewController.label.text == "new test value")
        XCTAssertTrue(viewController.textField.text == "new test value")
    }
    
}
