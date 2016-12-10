//
//  PAInvocation.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 10/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

public enum PAInvocationError: Error {
    case invalidData
    
    public var localizedDescription: String {
        switch self {
        case .invalidData:
            return NSLocalizedString("Unable to process selection data", comment: "Unable to process selection data (error message)")
        }
    }
}

public final class PAInvocation {
    
    public enum Platform: String {
        case iOS
        case macOS
        case tvOS
    }
    
    private struct Notifications {
        static let CreatePlayground = NSNotification.Name("br.com.guilhermerambo.PlayAlways.CreatePlaygroundFromString")
    }
    
    private struct Keys {
        static let buffer = "buffer"
        static let platform = "platform"
    }
    
    public init() {
        
    }
    
    private var token: NSObjectProtocol?
    
    public func registerHandler(_ handler: @escaping (_ buffer: String, _ platform: String) -> Void) {
        token = DistributedNotificationCenter.default().addObserver(forName: Notifications.CreatePlayground, object: nil, queue: OperationQueue.main) { notification in
            guard let json = notification.object as? String else { return }
            guard let data = json.data(using: .utf8) else { return }
            
            guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
            guard let info = obj as? [String: String] else { return }
            
            guard let buffer = info[Keys.buffer] else { return }
            guard let platform = info[Keys.platform] else { return }
            
            handler(buffer, platform)
        }
    }
    
    public class func invoke(with buffer: String, platform: Platform = .iOS) throws {
        let info = [
            Keys.buffer: buffer,
            Keys.platform: platform.rawValue.lowercased()
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: info, options: [])
            if let json = String(data: data, encoding: .utf8) {
                DistributedNotificationCenter.default().postNotificationName(Notifications.CreatePlayground, object: json, userInfo: nil, deliverImmediately: true)
            }
        } catch {
            throw PAInvocationError.invalidData
        }
    }
    
    deinit {
        if let token = token {
            DistributedNotificationCenter.default().removeObserver(token)
        }
    }
    
}
