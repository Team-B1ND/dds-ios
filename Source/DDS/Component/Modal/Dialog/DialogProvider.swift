import Foundation

public final class DialogProvider: ObservableObject, ModalProvider {
    
    public struct Builder {
        let title: String
        let message: String?
        let secondaryButton: DialogButton?
        let primaryButton: DialogButton?
        let provider: DialogProvider
        
        public init(
            title: String,
            provider: DialogProvider
        ) {
            self.title = title
            self.message = nil
            self.secondaryButton = nil
            self.primaryButton = nil
            self.provider = provider
        }
        
        private init(
            title: String,
            message: String?,
            secondaryButton: DialogButton?,
            primaryButton: DialogButton?,
            provider: DialogProvider
        ) {
            self.title = title
            self.message = message
            self.secondaryButton = secondaryButton
            self.primaryButton = primaryButton
            self.provider = provider
        }
        
        public func message(_ message: String?) -> Self {
            .init(title: title, message: message, secondaryButton: secondaryButton, primaryButton: primaryButton, provider: provider)
        }
        
        public func secondaryButton(_ title: String, action: @escaping () -> Void) -> Self {
            .init(title: self.title, message: message, secondaryButton: .init(title, action: action), primaryButton: primaryButton, provider: provider)
        }
        
        public func primaryButton(_ title: String, action: @escaping () -> Void) -> Self {
            .init(title: self.title, message: message, secondaryButton: secondaryButton, primaryButton: .init(title, action: action), provider: provider)
        }
        
        public func show() {
            provider.title = title
            provider.message = message
            provider.secondaryButton = secondaryButton
            provider.primaryButton = primaryButton
            provider.isPresent = true
        }
    }
    
    @Published public var isPresent = false
    @Published var title: String = ""
    @Published var message: String?
    @Published var secondaryButton: DialogButton?
    @Published var primaryButton: DialogButton?
    
    public init() {}
    
    public func present(
        _ title: String
    ) -> Builder {
        .init(title: title, provider: self)
    }
}
