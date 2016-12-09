//
//  StatusItemController.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

enum MenuOptions: Int {
    case iOS
    case macOS
    case tvOS
    case iOSWithPanel
    case macOSWithPanel
    case tvOSWithPanel
}

final class StatusItemController {
    
    private let menu: NSMenu = {
        let m = NSMenu(title: "PlayAlways")
        
        let newEmbeddedItem = NSMenuItem(title: NSLocalizedString("New iOS Playground", comment: "New iOS Playgroud menu item"), action: #selector(AppDelegate.createNewPlayground(sender:)), keyEquivalent: "1")
        newEmbeddedItem.tag = MenuOptions.iOS.rawValue
        m.addItem(newEmbeddedItem)
        
        let newEmbeddedItemAlternate = NSMenuItem(title: NSLocalizedString("New iOS Playground…", comment: "New iOS Playgroud menu item (alternate, with ellipsis)"), action: #selector(AppDelegate.createNewPlayground(sender:)), keyEquivalent: "1")
        newEmbeddedItemAlternate.tag = MenuOptions.iOSWithPanel.rawValue
        newEmbeddedItemAlternate.isAlternate = true
        newEmbeddedItemAlternate.keyEquivalentModifierMask = [.command, .option]
        m.addItem(newEmbeddedItemAlternate)
        
        let newMacItem = NSMenuItem(title: NSLocalizedString("New macOS Playground", comment: "New macOS Playgroud menu item"), action: #selector(AppDelegate.createNewPlayground(sender:)), keyEquivalent: "2")
        newMacItem.tag = MenuOptions.macOS.rawValue
        m.addItem(newMacItem)
        
        let newMacItemAlternate = NSMenuItem(title: NSLocalizedString("New macOS Playground…", comment: "New macOS Playgroud menu item (alternate, with ellipsis)"), action: #selector(AppDelegate.createNewPlayground(sender:)), keyEquivalent: "2")
        newMacItemAlternate.tag = MenuOptions.macOSWithPanel.rawValue
        newMacItemAlternate.isAlternate = true
        newMacItemAlternate.keyEquivalentModifierMask = [.command, .option]
        m.addItem(newMacItemAlternate)
        
        let newTVItem = NSMenuItem(title: NSLocalizedString("New tvOS Playground", comment: "New tvOS Playgroud menu item"), action: #selector(AppDelegate.createNewPlayground(sender:)), keyEquivalent: "3")
        newTVItem.tag = MenuOptions.tvOS.rawValue
        m.addItem(newTVItem)
        
        let newTVItemAlternate = NSMenuItem(title: NSLocalizedString("New tvOS Playground…", comment: "New tvOS Playgroud menu item (alternate, with ellipsis)"), action: #selector(AppDelegate.createNewPlayground(sender:)), keyEquivalent: "3")
        newTVItemAlternate.tag = MenuOptions.tvOSWithPanel.rawValue
        newTVItemAlternate.isAlternate = true
        newTVItemAlternate.keyEquivalentModifierMask = [.command, .option]
        m.addItem(newTVItemAlternate)
        
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
