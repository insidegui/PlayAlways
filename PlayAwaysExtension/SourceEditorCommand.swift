//
//  SourceEditorCommand.swift
//  PlayAwaysExtension
//
//  Created by Guilherme Rambo on 10/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        
        completionHandler(nil)
    }
    
}
