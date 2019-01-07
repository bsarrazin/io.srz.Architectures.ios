import Foundation

protocol View: class {
    var textFieldValue: String { get set }
}

class Presenter {
    
    var model: Model
    let observer: NSObjectProtocol
    weak var view: View?
    
    init(model: Model, view: View) {
        self.model = model
        self.view = view
        
        self.view?.textFieldValue = model.value
        
        self.observer = NotificationCenter.default
            .addObserver(
                forName: Model.valueDidChangeNotification,
                object: nil,
                queue: nil,
                using: { [view] notification in
                    view.textFieldValue = notification.userInfo?[Model.valueDidChangeUserInfoKey] as? String ?? ""
            })
    }
    
    func commit() {
        model.value = view?.textFieldValue ?? ""
    }
    
}
