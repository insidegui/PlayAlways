//
//  AppDelegate.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    private var router: AppRouter!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.router = AppRouter(statusItemController: StatusItemController(), playgroundMaker: PlayAlwaysMaker())
    }

    @IBAction func createNewEmbeddedPlayground(_ sender: Any?) {
        router.createPlayground(mac: false)
    }
    
    @IBAction func createNewMacPlayground(_ sender: Any?) {
        router.createPlayground(mac: true)
    }
    
    @IBAction func createNewEmbeddedPlaygroundWithPanel(_ sender: Any?) {
        router.createPlayground(mac: false, showOptions: true)
    }
    
    @IBAction func createNewMacPlaygroundWithPanel(_ sender: Any?) {
        router.createPlayground(mac: true, showOptions: true)
    }
}

