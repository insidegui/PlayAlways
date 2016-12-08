//
//  MainWindowController.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

/// Currently unused, will be used to show playground creation options in the future
class MainWindowController: NSWindowController {

    init() {
        let frame = NSRect(x: 0, y: 0, width: 270, height: 140)
        let window = NSWindow(contentRect: frame, styleMask: [.titled, .closable], backing: .buffered, defer: false)
        window.center()
        
        super.init(window: window)
        windowDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
