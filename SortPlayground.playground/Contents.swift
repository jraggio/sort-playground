// John Raggio - comment added on the branch
import Cocoa
import CoreFoundation
import Foundation  // without this import the formatting below did not work, but did not give an error either

import XCPlayground

var playgroundPage: XCPlaygroundPage = XCPlaygroundPage.currentPage



class CustomView: NSView {
    override init(frame: NSRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        // fill the background
        color.setFill()
        NSRectFill(self.bounds)
        
        //Swift.print(self.numberList.count)
       
        //draw the bars for the array
        for i in 0..<self.drawList.count{
            drawBar(i, length: self.drawList[i])
        }
    }
    
    func drawBar(index:Int, length:Int){
        //Swift.print("index:\(index), length:\(length)")
        NSColor.redColor().setFill()
        let r  = NSMakeRect(0, y+CGFloat(index*10), CGFloat(length*20), 3)
        NSRectFill(r)

    }
    
    var color = NSColor.greenColor()
    var y: CGFloat = 5
    var drawList : Array<Int> = []
    
}


var view = CustomView(frame:
    NSRect(x: 0, y: 0, width: 300, height: 300))

class ParkBenchTimer {
    
    let startTime:CFAbsoluteTime
    var endTime:CFAbsoluteTime?
    
    init() {
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func stop() -> CFAbsoluteTime {
        endTime = CFAbsoluteTimeGetCurrent()
        
        return duration!
    }
    
    var duration:CFAbsoluteTime? {
        if let endTime = endTime {
            return endTime - startTime
        } else {
            return nil
        }
    }
}

func insertionSort(numberList: Array<Int>) -> Array<Int> {
    //check for trivial case
    guard numberList.count > 1 else { return numberList }
    //mutated copy
    var output = numberList
    for primaryIndex in 0..<output.count {
        //        print("primary = \(primaryIndex)")
        //        print(output)
        let key = output[primaryIndex]
        for var secondaryIndex = primaryIndex; secondaryIndex > -1; secondaryIndex -= 1 {
            //            print("secondary = \(secondaryIndex)")
            //            print(output)
            if key > output[secondaryIndex] {
                //move into correct position
                // suprised that this is slightly faster than the swap below
                //                output.removeAtIndex(secondaryIndex + 1)
                //                output.insert(key, atIndex: secondaryIndex)
                
                // This one is 10x faster than the other two
                swap(&output[secondaryIndex], &output[secondaryIndex+1])
                
                //                swap(&output, index1:secondaryIndex, index2:secondaryIndex+1)
                //                        print("swapped, secondaryIndex = \(secondaryIndex), key = \(key), primaryIndex = \(primaryIndex) ")
                //                        print(output)
                
                view.drawList = output
                view.needsDisplay
                
                playgroundPage.captureValue(view, withIdentifier: "My View")
                
            }
        }
    }
    
 
    return output
}

func swap(inout a: Array<Int>, index1: Int, index2:Int){
    let temp = a[index1];
    a[index1] = a[index2]
    a[index2] = temp
}


var numberList : Array<Int> = [8, 2, 10, 9, 11, 1, 7, 3, 5,6,4,3,8,9,10,8, 2, 10, 9, 11, 1, 7, 3, 4,11,4,3,8,9,10]
var listCopy = numberList


print("\nnumberList before call to insertion sort")
print(numberList)


print("\nnumberList after call to insertion sort")
var timer = ParkBenchTimer()
var sorted = insertionSort(numberList)
print(sorted)
var s = String(format: "%.4f", timer.stop())
print("The task took \(s) seconds.")

print("\nusing built in array sort with closure")
timer = ParkBenchTimer()
print(listCopy.sort() { $0 > $1 } )
s = String(format: "%.4f", timer.stop())
print("The task took \(s) seconds.")
//let time = (s as NSString).doubleValue









