import Foundation
import CoreMedia
import AVFoundation
import CoreImage



public struct CircularBuffer<Element> {
    private var data: [Element?]
    private var head: Int = 0
    private var tail: Int = 0

    public init(count: Int) {
        data = [Element?](repeating: nil, count: count)
    }

    public mutating func enqueue(_ element: Element) -> Bool {
        if ((tail + 1) % data.count) == head {
            // Buffer is full.
            //data[head] = nil // release oldest element from memory before overwriting it (if it is of reference type)
            head = (head + 1) % data.count
        }
        data[tail] = element
        tail = (tail + 1) % data.count
        return true
    }
    
    public func elements() -> [Element?] {
        Array(data)
    }

    public func middleElementLeftmost() -> (Int, Element)? {
        let middleIndex = (data.count - 1) / 2
        if let middleElement = data[middleIndex] {
            return (middleIndex, middleElement)
        }
        return nil
    }
    
    public func middleElementRightmost() -> (Int, Element)? {
        let middleIndex = data.count / 2
        if let middleElement = data[middleIndex] {
            return (middleIndex, middleElement)
        }
        return nil
    }

    public mutating func dequeue() -> Element? {
        if head == tail {
            return nil // the buffer is empty
        }
        let element = data[head]
        //data[head] = nil // release object from memory (if it is of reference type)
        head = (head + 1) % data.count
        return element
    }
    
    public func getElementsAroundIndex(index: Int, numElements: Int) -> [Element] {
        var elements: [Element] = []
        var elementsRetrieved = 0
        var targetIndex = index
        
        // Retrieve elements on the left side of the given index
        while elementsRetrieved < numElements - 1 && targetIndex >= 0 {
            if let element = data[targetIndex % data.count] {
                elements.insert(element, at: 0)
                elementsRetrieved += 1
            }
            targetIndex -= 1
        }
        
        targetIndex = index + 1
        
        // Retrieve elements on the right side of the given index
        while elementsRetrieved < numElements && targetIndex < data.count - 1 {
            if let element = data[targetIndex % data.count] {
                elements.append(element)
                elementsRetrieved += 1
            }
            targetIndex += 1
        }
        
        return elements
    }
}
