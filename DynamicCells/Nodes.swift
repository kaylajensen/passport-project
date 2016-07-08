

import Foundation
import UIKit

class Nodes {
    
    var nodeName: String
    var upperBound: Int
    var lowerBound: Int
    var children = [Int]()
    var key : String
    
    init(nodeName: String, upperBound: Int, lowerBound: Int, key: String) {
        self.nodeName = nodeName
        self.upperBound = upperBound
        self.lowerBound = lowerBound
        self.key = key
    }
    
    func printMe() {
        print("\(nodeName) lower: \(lowerBound) upper: \(upperBound)")
    }
    
    func generateChildren(num: Int) {
        let n = [Int]()
        children = n
        if num > 15 || num < 1 {
            return
        }
        
        for _ in 0...num-1 {
            let r = randomNumber(self.lowerBound...self.upperBound)
            children.append(r)
        }
    }
    
    func randomNumber(range: Range<Int> = 1...6) -> Int {
        let min = range.startIndex
        let max = range.endIndex
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
    func printChildren() {
        if children.count != 0 {
            for n in 0...children.count-1 {
                print("   \(children[n])")
            }
        }
        else {
            print("   No children")
        }
    }
    
    func editBounds(lower: Int, upper: Int) {
        self.lowerBound = lower
        self.upperBound = upper
        children.removeAll()
    }
    
    func removeNode() {
        
    }
    func getNodeName() -> String {
        return nodeName
    }
    func getLowerBound() -> Int {
        return lowerBound
    }
    func getUpperBound() -> Int {
        return upperBound
    }
    func setUpper(u: Int) {
        upperBound = u
    }
    func setLower(l: Int) {
        lowerBound = l
    }
    func getNumKids() -> Int {
        return children.count
    }
    
    
}
