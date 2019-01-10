import Foundation

class UseCase {
    
    var model: Model
    var value: String {
        get { return model.value }
        set { model.value = newValue }
    }
    private var observer: NSObjectProtocol!
    weak var presenter: Presenter?
    
    init(model: Model) {
        self.model = model
        self.value = model.value
        self.observer = NotificationCenter.default
            .addObserver(
                forName: Model.valueDidChangeNotification,
                object: nil,
                queue: nil,
                using: { [unowned self] notification in
                    self.presenter?.value = notification.userInfo?[Model.valueDidChangeUserInfoKey] as? String ?? ""
                })
    }
}
