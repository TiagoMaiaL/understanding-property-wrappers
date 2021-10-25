//: [Previous](@previous)

import Foundation

// MARK: - Wrapper

struct UserDefault<Value: Codable> {
    let storage: UserDefaults
    private let key: String
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    
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
    
    init(key: String) {
        self.key = key
        self.storage = .standard
    }
    
    init(key: String, storage: UserDefaults) {
        self.key = key
        self.storage = storage
    }
}

// MARK: - Did launch

var _didLaunchDefault = UserDefault<Bool>(key: KeyConstants.didLaunchKey)
_didLaunchDefault.storage.removeObject(forKey: KeyConstants.didLaunchKey)
var didLaunch: Bool? {
    get {
        _didLaunchDefault.wrappedValue
    }
    set {
        _didLaunchDefault.wrappedValue = newValue
    }
}

debugPrint(didLaunch ?? false)
didLaunch = true
debugPrint(didLaunch ?? false)

// MARK: - Last request date

var _lastRequestDefault = UserDefault<Date>(key: KeyConstants.lastRequestDateKey)
_lastRequestDefault.storage.removeObject(forKey: KeyConstants.lastRequestDateKey)
var lastRequestDate: Date? {
    get {
        _lastRequestDefault.wrappedValue
    }
    set {
        _lastRequestDefault.wrappedValue = newValue
    }
}

debugPrint(lastRequestDate?.description ?? "")
lastRequestDate = Date()
debugPrint(lastRequestDate?.description ?? "")

// MARK: - User Settings

var _userSettingsDefault = UserDefault<UserSettings>(key: KeyConstants.userSettingsKey)
_userSettingsDefault.storage.removeObject(forKey: KeyConstants.userSettingsKey)
var userSettings: UserSettings? {
    get {
        _userSettingsDefault.wrappedValue
    }
    set {
        _userSettingsDefault.wrappedValue = newValue
    }
}

debugPrint(userSettings?.description ?? "")
userSettings = UserSettings(theme: .white, locale: .current, usesTouchId: false)
debugPrint(userSettings?.description ?? "")

//: [Next](@next)
