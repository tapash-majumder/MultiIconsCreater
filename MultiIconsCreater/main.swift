#!/usr/bin/swift

//
//  main.swift
//  MultiIconsCreater
//
//  Created by Tapash Majumder on 10/20/16.
//  Copyright © 2016 Stashword Inc. All rights reserved.
//

import Foundation

print("Hello, World!")

let sourceFile = "app-1024x768.svg"
let outputDir = "output"
let outputPrefix = "icon"

let requirements = [
    ["width" : 60, "height" : 45, "dims" : [2, 3]],
    ["width" : 67, "height" : 50, "dims" : [2]],
    ["width" : 74, "height" : 55, "dims" : [2]],
    ["width" : 27, "height" : 20, "dims" : [2, 3]],
    ["width" : 32, "height" : 24, "dims" : [2, 3]],
]

func createDestination() {
    let process = Process()
    process.launchPath = "/bin/mkdir"
    process.arguments = ["\(outputDir)"]
    
    process.launch()
    process.waitUntilExit()
}

func doRequirements() {
    for requirement in requirements {
        guard let width = requirement["width"] as? Int else {
            return
        }
        guard let height = requirement["height"] as? Int else {
            return
        }
        guard let dims = requirement["dims"] as? [Int] else {
            return
        }
        
        for dim in dims {
            createOneIcon(width: width * dim, height: height * dim)
            moveIconToDestination(width: width, height: height, dim: dim)
        }
    }
}

func createOneIcon(width: Int, height: Int) {
    let process = Process()
    process.launchPath = "/usr/bin/qlmanage"
    process.arguments = ["-t", "-s", "\(width):\(height)", "-o", ".", sourceFile]
    
    process.launch()
    process.waitUntilExit()
}

// icon-30x20@2x.png
func moveIconToDestination(width: Int, height: Int, dim: Int) {
    let process = Process()
    process.launchPath = "/bin/mv"
    process.arguments = ["\(sourceFile).png", "\(outputDir)/\(outputPrefix)-\(width)x\(height)@\(dim)x.png"]
    
    process.launch()
    process.waitUntilExit()
}

func main() {
    createDestination()
    doRequirements()
}

main()

