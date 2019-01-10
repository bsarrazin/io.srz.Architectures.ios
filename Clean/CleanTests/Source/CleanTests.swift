import XCTest
@testable import Clean

class CleanTests: XCTestCase {
    
    func testUseCase() {
        class TestView: View {
            var value: String = ""
        }
        let model = Model(value: "test clean value")
        let view = TestView()
        view.value = model.value
        
        let useCase = UseCase(model: model)
        let presenter = DefaultPresenter(useCase: useCase)
        presenter.view = view
        
        XCTAssertTrue(useCase.value == "test clean value")
        XCTAssertTrue(presenter.value == "test clean value")
        XCTAssertTrue(view.value == "test clean value")
        
        useCase.value = "new usecase test clean value"
        XCTAssertTrue(presenter.value == "new usecase test clean value")
        XCTAssertTrue(view.value == "new usecase test clean value")
        
        presenter.value = "new presenter test clean value"
        XCTAssertFalse(useCase.value == "new presenter test clean value")
        presenter.commit()
        XCTAssertTrue(useCase.value == "new presenter test clean value")
        XCTAssertTrue(view.value == "new presenter test clean value")
    }
    
}
