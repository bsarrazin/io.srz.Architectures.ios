import Foundation

struct Model {
    var value: String {
        didSet { postNotification(with: value) }
    }
}

extension Model {
    private func postNotification(with value: String) {
        NotificationCenter.default.post(
            name: Model.valueDidChangeNotification,
            object: nil,
            userInfo: [Model.valueDidChangeUserInfoKey: value]
        )
    }
    
    static let valueDidChangeNotification: Notification.Name = .init("Model.valueDidChangeNotificationName")
    static let valueDidChangeUserInfoKey: String = "Model.valueDidChangeUserInfoKey"
}
