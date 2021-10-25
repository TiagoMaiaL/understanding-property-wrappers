//: [Previous](@previous)

import Foundation

// MARK: - Property Wrapper

@propertyWrapper
struct UserDefault<Value: Codable> {
    private let storage: UserDefaults
    private let key: String
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    
    var projectedValue: UserDefaults { storage }
    
    var wrappedValue: Value? {
        mutating get {
            guard let data = storage.data(forKey: key) else {
                return nil
            }
            
            do {
                let value = try decoder.decode(Value?.self, from: data)
                return value
            } catch {
                debugPrint("Encoding Error: \(error.localizedDescription)")
                assertionFailure()
                return nil
            }
        }
        set {
            do {
                let data = try encoder.encode(newValue)
                storage.set(data, forKey: key)
            } catch {
                debugPrint("Encoding Error: \(error.localizedDescription)")
                assertionFailure()
            }
        }
    }
    
    init(wrappedValue: Value? = nil, key: String) {
        self.key = key
        self.storage = .standard
        self.wrappedValue = wrappedValue
    }
    
    init(wrappedValue: Value? = nil, key: String, storage: UserDefaults) {
        self.key = key
        self.storage = storage
        self.wrappedValue = wrappedValue
    }
}

// MARK: - Properties

// Property wrappers aren't supported in top-level code yet.
// That's why we are using this final class to demo the wrappers usage.
final class Properties {

    @UserDefault(key: KeyConstants.didLaunchKey)
    var didLaunch: Bool?

    @UserDefault(key: KeyConstants.lastRequestDateKey)
    var lastRequestDate: Date?
    
    @UserDefault(key: KeyConstants.userSettingsKey)
    var settings: UserSettings?
    
    init() {
        $didLaunch.removeObject(forKey: KeyConstants.didLaunchKey)
        $lastRequestDate.removeObject(forKey: KeyConstants.lastRequestDateKey)
        $settings.removeObject(forKey: KeyConstants.userSettingsKey)
    }
}

// MARK: - Usage

let properties = Properties()

debugPrint(properties.didLaunch ?? false)
properties.didLaunch = true
debugPrint(properties.didLaunch ?? false)

debugPrint(properties.lastRequestDate?.description ?? "")
properties.lastRequestDate = Date()
debugPrint(properties.lastRequestDate?.description ?? "")

debugPrint(properties.settings?.description ?? "")
properties.settings = UserSettings(theme: .white, locale: .current, usesTouchId: false)
debugPrint(properties.settings?.description ?? "")

//: [Next](@next)
