//
//  Commands.swift
//  PlayAwaysExtension
//
//  Created by Guilherme Rambo on 10/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation
import XcodeKit
import PACore

final class Commander {
    
    class func perform(with invocation: XCSourceEditorCommandInvocation, for platform: PAInvocation.Platform) {
        do {
            try PAInvocation.invoke(with: invocation.buffer.completeBuffer, platform: platform)
        } catch {
            NSAlert(error: error).runModal()
        }
    }
    
}

class EmbeddedCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        Commander.perform(with: invocation, for: .iOS)
        
        completionHandler(nil)
    }
    
}

class MacCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        Commander.perform(with: invocation, for: .macOS)
        
        completionHandler(nil)
    }
    
}

class TVCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        Commander.perform(with: invocation, for: .tvOS)
        
        completionHandler(nil)
    }
    
}
