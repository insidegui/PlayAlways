//
//  FinderHelper.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation
import Cocoa

final class FinderHelper {
    
    static let path: String = "PlayPath"
    
    class func getLocation(fallback: String) -> String {
        
        guard let path: String = PersistenceHelper.read(key: FinderHelper.path) as? String else { return selectLocation(fallback: fallback) }
        
        return path
        
    }
    
    class func selectLocation(fallback: String? = nil) -> String {
        
        let dialog: NSOpenPanel = NSOpenPanel()
        
        dialog.prompt = "Select"
        dialog.worksWhenModal = true
        dialog.allowsMultipleSelection = false
        dialog.canChooseDirectories = true
        dialog.canCreateDirectories = true
        dialog.canChooseFiles = false
        dialog.resolvesAliases = false
        dialog.title = "Select a location"
        dialog.message = "Select a location to create playgrounds into"
        dialog.runModal()
        
        if let selected = dialog.url {
            
            PersistenceHelper.save(value: selected.absoluteString as AnyObject, key: FinderHelper.path)
            
            return selected.absoluteString
        
        } else {
            
            if let path: String = PersistenceHelper.read(key: FinderHelper.path) as? String { return path }
            else { return fallback ?? "" }
            
        }
        
    }
    
}
