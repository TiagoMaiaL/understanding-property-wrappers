import Foundation

public struct UserSettings: Codable, CustomStringConvertible {
    public let theme: Theme
    public let locale: Locale
    public let usesTouchId: Bool
    
    public init(theme: Theme, locale: Locale, usesTouchId: Bool) {
        self.theme = theme
        self.locale = locale
        self.usesTouchId = usesTouchId
    }
    
    public var description: String {
        """
            Theme: \(theme) \
            Locale: \(locale) \
            Uses touch ID: \(usesTouchId)
        """
    }
}
