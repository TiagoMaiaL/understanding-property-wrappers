//: [Previous](@previous)

import Foundation

// MARK: - Wrapper

struct BooleanUserDefault {
    let storage: UserDefaults
    private let key: String
    
    var wrappedValue: Bool {
        get {
            storage.bool(forKey: key)
        }
        set {
            storage.set(newValue, forKey: key)
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

// MARK: - Usage

var _default = BooleanUserDefault(key: KeyConstants.didLaunchKey)
_default.storage.set(false, forKey: KeyConstants.didLaunchKey)
var didLaunch: Bool {
    get {
        _default.wrappedValue
    }
    set {
        _default.wrappedValue = newValue
    }
}

debugPrint(didLaunch)
didLaunch = true
debugPrint(didLaunch)

//: [Next](@next)
