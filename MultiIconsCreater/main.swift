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

let sourceFile = "/users/tapash/prog/other/misc/swift/MultiIconsCreater/rocket-2.svg"
let outputDir = "/users/tapash/temp/output"
let outputPrefix = "icon"

let requirements = [
    ["width" : 60, "height" : 60, "dims" : [2, 3]],
    ["width" : 76, "height" : 76, "dims" : [1, 2]],
    ["width" : 83.5, "height" : 83.5, "dims" : [2]],
    ["width" : 1024, "height" : 1024, "dims" : [1]],
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
        guard let width = requirement["width"] as? Double else {
            return
        }
        guard let height = requirement["height"] as? Double else {
            return
        }
        guard let dims = requirement["dims"] as? [Int] else {
            return
        }

        for dim in dims {
            let intWidth = Int(Double(dim) * width)
            let intHeight = Int(Double(dim) * height)
            createOneIcon(width: intWidth, height: intHeight)
            moveIconToDestination(width: width, height: height, dim: dim)
        }
    }
}

func createOneIcon(width: Int, height: Int) {
    let process = Process()
    process.launchPath = "/usr/bin/qlmanage"
    process.arguments = ["-t", "-s", "\(width):\(height)", "-o", "/users/tapash/prog/other/misc/swift/MultiIconsCreater", sourceFile]
    
    process.launch()
    process.waitUntilExit()
}

// icon-30x20@2x.png
func moveIconToDestination(width: Double, height: Double, dim: Int) {
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

