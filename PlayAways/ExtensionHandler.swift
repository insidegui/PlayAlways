//
//  ExtensionHandler.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 10/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation
import PACore

final class ExtensionHandler {
    
    private let invocation = PAInvocation()
    private weak var router: AppRouter?
    
    init(router: AppRouter) {
        self.router = router
        
        invocation.registerHandler { [weak self] buffer, platform in
            let options: MenuOptions
            
            switch platform {
            case "macos":
                options = .macOS
            case "tvos":
                options = .tvOS
            default:
                options = .iOS
            }
            
            self?.router?.createPlayground(with: options, contents: buffer)
        }
    }
    
}
