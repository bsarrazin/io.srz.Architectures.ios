@testable import MVVM
import RxBlocking
import RxCocoa
import RxSwift
import XCTest

class MVVMTests: XCTestCase {

    func testProc() throws {
        let model = Model(value: "test proc value")
        let viewModel = ProcViewModel(model: model)
        
        let expectation = keyValueObservingExpectation(for: viewModel, keyPath: "value") { (model, userInfo) -> Bool in
            XCTAssertTrue(userInfo["new"] as! String == "new test proc value")
            return true
        }
        
        viewModel.commit(value: "new test proc value")
        
        wait(for: [expectation], timeout: 10)
    }

    func testRx() throws {
        let bag = DisposeBag()
        let expectation = self.expectation(description: #function)
        let model = Model(value: "test rx value")
        let viewModel = ViewModel(model: model)
        viewModel.value
            .skip(1) // skip the initial value
            .drive(onNext: { value in
                XCTAssertTrue(value == "new test rx value")
                expectation.fulfill()
            })
            .disposed(by: bag)
        
        
        viewModel.commit.onNext("new test rx value")
        
        wait(for: [expectation], timeout: 10)
    }

}
