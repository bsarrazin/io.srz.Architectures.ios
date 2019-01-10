import Foundation

protocol Presenter: class {
    var value: String { get set }
    var view: View? { get set }
    func commit()
}

class DefaultPresenter: Presenter {
    var useCase: UseCase
    weak var view: View? {
        didSet { view?.value = value }
    }
    
    var value: String {
        didSet { view?.value = value}
    }
    
    init(useCase: UseCase) {
        self.useCase = useCase
        self.value = useCase.value
        self.useCase.presenter = self
    }
    
    func commit() {
        useCase.value = view?.value ?? ""
    }
}
