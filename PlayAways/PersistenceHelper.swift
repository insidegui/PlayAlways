//
//  PersistenceHelper.swift
//  PlayAways
//
//  Created by Leonardo Cardoso on 09/12/2016.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

class PersistenceHelper {
    
    class func save(value: AnyObject, key: String) { UserDefaults.standard.set(value, forKey: key) }
    
    class func read(key: String) -> AnyObject? { return UserDefaults.standard.object(forKey: key) as AnyObject? }
    
    class func remove(key: String) { UserDefaults.standard.removeObject(forKey: key) }
    
}
