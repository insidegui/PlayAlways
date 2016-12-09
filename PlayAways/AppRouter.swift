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
    
    func createPlayground(with options: MenuOptions) {
        let platform: PlaygroundPlatform
        var showOptions = false
        
        switch options {
        case .iOS:
            platform = .iOS
        case .iOSWithPanel:
            platform = .iOS
            showOptions = true
        case .macOS:
            platform = .macOS
        case .macOSWithPanel:
            platform = .macOS
            showOptions = true
        case .tvOS:
            platform = .tvOS
        case .tvOSWithPanel:
            platform = .tvOS
            showOptions = true
        }
        
        if showOptions {
            let panel = NSSavePanel()

            let titleFormat = NSLocalizedString("New %@ Playground", comment: "New [platform name] Playground")
            panel.title = String(format: titleFormat, platform.rawValue)
            
            panel.prompt = NSLocalizedString("Create", comment: "Create playground (button title)")
            
            panel.runModal()
            
            guard let url = panel.url else { return }
            
            createPlayground(for: platform, at: url)
        } else {
            createPlayground(for: platform, at: nil)
        }
        
    }
    
    private func createPlayground(for platform: PlaygroundPlatform, at location: URL?) {
        var playgroundUrl: URL?
        
        if let location = location {
            let directory = location.deletingLastPathComponent().path
            let name = location.deletingPathExtension().lastPathComponent
            
            do {
                playgroundUrl = try playgroundMaker.createPlayground(named: name, at: directory, platform: platform)
            } catch {
                handle(error)
            }
        } else {
            guard let desktopDir = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first else {
                NSLog("NSSearchPathForDirectoriesInDomains returned nil for desktop dir, this should never happen!")
                return
            }
            
            let directory = FinderHelper.getLocation(fallback: desktopDir)
            
            do {
                playgroundUrl = try playgroundMaker.createPlayground(named: nil, at: directory, platform: platform)
            } catch {
                handle(error)
            }
        }
        
        if let url = playgroundUrl {
            NSWorkspace.shared().open(url)
        }
    }
    
    private func handle(_ error: Error) {
        NSAlert(error: error).runModal()
    }
    
}
