//
//  PlaygroundMaker.swift
//  PlayAways
//
//  Created by Guilherme Rambo on 08/12/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

protocol PlaygroundMaker {
    func createPlayground(named name: String?, at destination: String, mac: Bool) throws
}
