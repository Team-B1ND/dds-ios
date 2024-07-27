import Foundation

public final class DialogProvider: ObservableObject, ModalProvider {
    
    @Published public var isPresent = false
    @Published var title: String = ""
    @Published var message: String?
    @Published var secondaryButton: DialogButton?
    @Published var primaryButton: DialogButton?
    
    public init() {}
    
    @discardableResult
    public func present(
        _ title: String
    ) -> Self {
        self.title = title
        self.message = nil
        self.secondaryButton = nil
        self.primaryButton = nil
        self.isPresent = true
        return self
    }
    
    @discardableResult
    public func message(
        _ message: String
    ) -> Self {
        self.message = message
        return self
    }
    
    @discardableResult
    public func secondaryButton(
        _ title: String,
        action: @escaping () -> Void
    ) -> Self {
        self.secondaryButton = .init(title, action: action)
        return self
    }
    
    @discardableResult
    public func primaryButton(
        _ title: String,
        action: @escaping () -> Void
    ) -> Self {
        self.primaryButton = .init(title, action: action)
        return self
    }
}
