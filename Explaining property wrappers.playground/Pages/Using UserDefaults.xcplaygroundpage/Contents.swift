import Foundation

let userDefaults = UserDefaults.standard

// MARK: - Reset

userDefaults.set(false, forKey: KeyConstants.didLaunchKey)
userDefaults.set(nil, forKey: KeyConstants.lastRequestDateKey)
userDefaults.set(nil, forKey: KeyConstants.userSettingsKey)

// MARK: - Did launch

var didLaunch = userDefaults.bool(forKey: KeyConstants.didLaunchKey)
if !didLaunch {
    userDefaults.set(true, forKey: KeyConstants.didLaunchKey)
}

// MARK: - Last request date

let lastRequestDate = Date()
userDefaults.set(lastRequestDate, forKey: KeyConstants.lastRequestDateKey)
userDefaults.value(forKey: KeyConstants.lastRequestDateKey)

// MARK: - User settings

let encoder = JSONEncoder()
let userSettings = UserSettings(theme: .dark, locale: .current, usesTouchId: true)
let data = try! encoder.encode(userSettings)

userDefaults.set(data, forKey: KeyConstants.userSettingsKey)

let decoder = JSONDecoder()
let retrievedSettingsData = userDefaults.data(forKey: KeyConstants.userSettingsKey)!
let retrievedSettings = try! decoder.decode(UserSettings.self, from: retrievedSettingsData)
