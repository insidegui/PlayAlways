//
//  PersistenceHelper.swift
//  PlayAways
//
//  Created by Leonardo Cardoso on 09/12/2016.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

protocol DefaultsStorage {
    func synchronize() -> Bool
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
}

extension UserDefaults: DefaultsStorage { }
extension NSUbiquitousKeyValueStore: DefaultsStorage { }

final class PersistenceHelper {
    
    fileprivate let storage: DefaultsStorage
    
    init(storage: DefaultsStorage) {
        self.storage = storage
    }
    
    func save(value: AnyObject, key: String) {
        storage.set(value, forKey: key)
    }
    
    func read(key: String) -> AnyObject? {
        return storage.object(forKey: key) as AnyObject?
    }
    
    func remove(key: String) {
        storage.removeObject(forKey: key)
    }
    
}

extension PersistenceHelper {
    
    private struct Keys {
        static let storagePath = "PlayPath"
    }
    
    class var userDefaults: PersistenceHelper {
        return PersistenceHelper(storage: UserDefaults.standard)
    }
    
    /// The path where the app will store the user's playgrounds by default
    var storagePath: String? {
        get {
            return storage.object(forKey: Keys.storagePath) as? String
        }
        set {
            storage.set(newValue, forKey: Keys.storagePath)
        }
    }
    
}
