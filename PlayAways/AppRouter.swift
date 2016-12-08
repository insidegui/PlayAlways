//
//  AppRouter.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

final class AppRouter {
    
    private let statusItemController: StatusItemController
    private let playgroundMaker: PlaygroundMaker
    
    init(statusItemController: StatusItemController, playgroundMaker: PlaygroundMaker) {
        self.statusItemController = statusItemController
        self.playgroundMaker = playgroundMaker
    }
    
    func createPlayground(mac: Bool, showOptions: Bool = false) {
        if showOptions {
            let panel = NSSavePanel()
            
            if mac {
                panel.title = NSLocalizedString("New macOS Playground", comment: "New macOS Playground (panel title)")
            } else {
                panel.title = NSLocalizedString("New iOS Playground", comment: "New iOS Playground (panel title)")
            }
            
            panel.prompt = NSLocalizedString("Create", comment: "Create playground (button title)")
            
            panel.runModal()
            
            guard let url = panel.url else { return }
            
            createPlayground(mac: mac, at: url)
        } else {
            createPlayground(mac: mac, at: nil)
        }
        
    }
    
    private func createPlayground(mac: Bool, at location: URL?) {
        if let location = location {
            let directory = location.deletingLastPathComponent().path
            let name = location.deletingPathExtension().lastPathComponent
            
            do {
                try playgroundMaker.createPlayground(named: name, at: directory, mac: mac)
            } catch {
                handle(error)
            }
        } else {
            guard let desktopDir = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first else {
                NSLog("NSSearchPathForDirectoriesInDomains returned nil for desktop dir, this should never happen!")
                return
            }
            
            let directory = FinderHelper.getFrontmostFinderWindowLocation(fallback: desktopDir)
            
            do {
                try playgroundMaker.createPlayground(named: nil, at: directory, mac: mac)
            } catch {
                handle(error)
            }
        }
    }
    
    private func handle(_ error: Error) {
        NSAlert(error: error).runModal()
    }
    
}
