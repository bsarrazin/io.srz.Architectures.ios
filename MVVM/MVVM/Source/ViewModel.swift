import RxCocoa
import RxSwift

// MARK: - Procedural
class ProcViewModel: NSObject {
    var model: Model
    var observer: NSObjectProtocol!
    @objc dynamic var value: String
    
    init(model: Model) {
        self.model = model
        self.value = model.value
        
        super.init()
        self.observer = NotificationCenter.default
            .addObserver(
                forName: Model.valueDidChangeNotification,
                object: nil,
                queue: nil,
                using: { [unowned self] notification in
                    self.value = notification.userInfo?[Model.valueDidChangeUserInfoKey] as? String ?? ""
                })
    }
    
    func commit(value: String) {
        model.value = value
    }
}

// MARK: - Reactive
class ViewModel {
    
    var model: Model
    
    var commit: AnyObserver<String> {
        return AnyObserver(subject)
    }
    var value: Driver<String> {
        return subject.startWith(model.value)
            .asDriver(onErrorJustReturn: "")
            .do(onNext: { [unowned self] in self.model.value = $0 })
    }
    
    private let subject: ReplaySubject<String>
    
    init(model: Model) {
        self.model = model
        subject = ReplaySubject<String>.create(bufferSize: 1)
    }
}
