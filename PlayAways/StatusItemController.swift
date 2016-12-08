//
//  StatusItemController.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

final class StatusItemController {
    
    private let menu: NSMenu = {
        let m = NSMenu(title: "PlayAlways")
        
        let newEmbeddedItem = NSMenuItem(title: NSLocalizedString("New iOS Playground", comment: "New iOS Playgroud menu item"), action: #selector(AppDelegate.createNewEmbeddedPlayground(_:)), keyEquivalent: "1")
        m.addItem(newEmbeddedItem)
        
        let newEmbeddedItemAlternate = NSMenuItem(title: NSLocalizedString("New iOS Playground…", comment: "New iOS Playgroud menu item (alternate, with ellipsis)"), action: #selector(AppDelegate.createNewEmbeddedPlaygroundWithPanel(_:)), keyEquivalent: "1")
        newEmbeddedItemAlternate.isAlternate = true
        newEmbeddedItemAlternate.keyEquivalentModifierMask = [.command, .option]
        m.addItem(newEmbeddedItemAlternate)
        
        let newMacItem = NSMenuItem(title: NSLocalizedString("New macOS Playground", comment: "New macOS Playgroud menu item"), action: #selector(AppDelegate.createNewMacPlayground(_:)), keyEquivalent: "2")
        m.addItem(newMacItem)
        
        let newMacItemAlternate = NSMenuItem(title: NSLocalizedString("New macOS Playground…", comment: "New macOS Playgroud menu item (alternate, with ellipsis)"), action: #selector(AppDelegate.createNewMacPlaygroundWithPanel(_:)), keyEquivalent: "2")
        newMacItemAlternate.isAlternate = true
        newMacItemAlternate.keyEquivalentModifierMask = [.command, .option]
        m.addItem(newMacItemAlternate)
        
        let quitItem = NSMenuItem(title: NSLocalizedString("Quit", comment: "Quit"), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        m.addItem(quitItem)
        
        return m
    }()
    
    private let statusItem: NSStatusItem
    
    init() {
        statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        statusItem.menu = menu
        statusItem.image = #imageLiteral(resourceName: "PlayAlways")
        statusItem.highlightMode = true
    }
    
}
