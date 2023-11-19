import XCTest
@testable import CircularBuffer

final class CircularBufferTests: XCTestCase {
    
    
    
    func testThatBufferKeepsSize() throws {
        
        var buff = CircleBuffer<Int>(count: 10)
        
        for i in 0...20 {
           _ = buff.enqueue(i)
        }
        
        XCTAssert(buff.elements().count <= 10)
        
    }
    
    func testThatBufferHasNoNilElements() throws {
        
        var buff = CircleBuffer<Int>(count: 10)
        
        for i in 0...100 {
           _ = buff.enqueue(i)
        }
        
        XCTAssert(buff.elements().compactMap{$0}.count ==  10)
    }
    
    
    func testThatBufferReturnsMiddleElement() throws {
        
        var buff = CircleBuffer<Int>(count: 10)
        
        for i in 0...50 {
           _ = buff.enqueue(i)
        }
        
        let middleLeft = buff.middleElementLeftmost()!.1
        let middleRight = buff.middleElementRightmost()!.1
        
        XCTAssert(middleLeft == 44)
        XCTAssert(middleRight == 45)
        
    }
    
    func testThatBufferReturnsElementsAroundIndex() throws {
        
        var buff = CircleBuffer<Int>(count: 10)
        
        for i in 0...50 {
           _ = buff.enqueue(i)
        }
        
        let elementsAround5 = buff.getElementsAroundIndex(index: 5, numElements: 3)

        XCTAssert(elementsAround5 == [44,45,46])
        
        
        let elementsAround1 = buff.getElementsAroundIndex(index: 1, numElements: 3)
        let elementsAround9 = buff.getElementsAroundIndex(index: 9, numElements: 3)
        
        XCTAssert(elementsAround1 == [50, 41, 42])
        XCTAssert(elementsAround9 == [48, 49]) // we don't mind less than `numElements` if its in the end of list.
        
    }
}
