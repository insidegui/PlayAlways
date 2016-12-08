//
//  FinderHelper.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

final class FinderHelper {
    
    class func getFrontmostFinderWindowLocation(fallback: String) -> String {
        let cmd = "tell application \"Finder\"\ntry\nset dir to the target of the front window\nreturn POSIX path of (dir as text)\non error\nreturn \"/\"\nend try\nend tell"
        let script = NSAppleScript(source: cmd)
        
        let results = script?.executeAndReturnError(nil)
        
        if let location = results?.stringValue, location != "/" {
            return location
        } else {
            return fallback
        }
    }
    
}
