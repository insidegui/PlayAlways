//
//  PlayAlways.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

public struct PlayAlways {
    
    public enum PlaygroundError: Error {
        case creation
        
        public var localizedDescription: String {
            switch self {
            case .creation:
                return NSLocalizedString("Unable to create playground at the specified location", comment: "Error message: unable to create playground at the specified location")
            }
        }
    }
    
    public let platform: String
    public let contents: String
    
    public init(platform: String, contents: String = "") {
        self.platform = platform.lowercased()
        self.contents = contents
    }
    
    var dateString: String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yMMdd_HHmmss"
        return dateFormat.string(from: date)
    }
    
    var systemFramework: String {
        switch platform {
        case "macos": return "Cocoa"
        default: return "UIKit"
        }
    }
    
    var currentDir: String {
        return FileManager.default.currentDirectoryPath
    }
    
    var importHeader: String {
        return "//: Playground - noun: a place where people can play\n\nimport \(systemFramework)\n\n"
    }
    
    var effectiveContents: String {
        return importHeader + (contents.isEmpty ? "var str = \"Hello, playground\"" : contents)
    }
    
    var contentHeader: String {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<playground version='5.0' target-platform='\(platform)'>\n\t<timeline fileName='timeline.xctimeline'/>\n</playground>\n"
    }
    
    func createPlaygroundFolder(_ path: String)  -> Bool {
        
        let fileManager = FileManager.default
        
        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            
            return true
        }
        catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    func writeFile(_ filename: String, at: String, content: String) -> Bool {
        
        let destinationPath = URL(fileURLWithPath: at).appendingPathComponent(filename)
        
        do {
            try content.write(to: destinationPath, atomically: true, encoding: String.Encoding.utf8)
            return true
        }
        catch let error as NSError {
            print(error)
        }
        
        return false
    }
    
    public func createPlayground(fileName: String? = nil, atDestination: String? = nil) throws -> URL {
        
        // essencial Playground structure:
        // |- folder with name.playground
        // |-- contents.xcplayground
        // |-- Contents.swift
        
        let chosenFileName = fileName ?? dateString
        let destinationDir = atDestination ?? currentDir
        
        let playgroundDir = URL(fileURLWithPath: destinationDir).appendingPathComponent(chosenFileName + ".playground")
        
        if createPlaygroundFolder(playgroundDir.path) &&
            writeFile("contents.xcplayground", at: playgroundDir.path, content: contentHeader) &&
            writeFile("Contents.swift", at: playgroundDir.path, content: effectiveContents) {
            
            return playgroundDir
        }
        
        throw PlaygroundError.creation
    }
}
