//
//  PlayAlwaysMaker.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation
import PACore

final class PlayAlwaysMaker: PlaygroundMaker {
    
    func createPlayground(named name: String?, at destination: String, mac: Bool) throws {
        let maker = PlayAlways(forMac: mac)
        try maker.createPlayground(fileName: name, atDestination: destination)
    }
    
}
