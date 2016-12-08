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
    
    public let forMac: Bool
    
    public init(forMac: Bool) {
        self.forMac = forMac
    }
    
    var dateString: String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "Ymd_HMS"
        return dateFormat.string(from: date)
    }
    
    var currentDir: String {
        return FileManager.default.currentDirectoryPath
    }
    
    var importHeader: String {
        return "//: Playground - noun: a place where people can play\n\nimport \(forMac ? "Cocoa" : "UIKit")\n\nvar str = \"Hello, playground\""
    }
    
    var contentHeader: String {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n<playground version='5.0' target-platform='\(forMac ? "macos" : "ios")'>\n\t<timeline fileName='timeline.xctimeline'/>\n</playground>\n"
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
    
    public func createPlayground(fileName: String? = nil, atDestination: String? = nil) throws {
        
        // essencial Playground structure:
        // |- folder with name.playground
        // |-- contents.xcplayground
        // |-- Contents.swift
        
        let chosenFileName = fileName ?? dateString
        let destinationDir = atDestination ?? currentDir
        
        let playgroundDir = URL(fileURLWithPath: destinationDir).appendingPathComponent(chosenFileName + ".playground")
        
        if createPlaygroundFolder(playgroundDir.path) &&
            writeFile("contents.xcplayground", at: playgroundDir.path, content: contentHeader) &&
            writeFile("Contents.swift", at: playgroundDir.path, content: importHeader) {
            
            let task = Process()
            task.launchPath = "/bin/sh"
            task.arguments = ["-c", "open \(playgroundDir.path)"]
            task.launch()
            task.waitUntilExit()
            
            return
        }
        
        throw PlaygroundError.creation
    }
}
