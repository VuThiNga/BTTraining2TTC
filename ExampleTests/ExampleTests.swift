//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by admin on 1/5/21.
//

import XCTest
@testable import Example

class ExampleTests: XCTestCase {

    func testDispatch() throws {
        let queue = Queue<Int>()
        
        DispatchQueue.concurrentPerform(iterations: 1000) { (i) in
            queue.pushDispatch(i)
        }
        
        DispatchQueue.concurrentPerform(iterations: 1000) { (i) in
            _ = queue.popDispatch()
        }
        
    }

    func testSemaphore() throws {
        let queue = Queue<Int>()
        DispatchQueue.concurrentPerform(iterations: 1000) { (i) in
            queue.pushSemaphore(i)
        }
        
        DispatchQueue.concurrentPerform(iterations: 1000) { (i) in
            _ = queue.popSemaphore()
        }
    }
    
    func testLock() throws {
        let queue = Queue<Int>()
        DispatchQueue.concurrentPerform(iterations: 1000) { (i) in
            queue.pushLock(i)
        }
        
        DispatchQueue.concurrentPerform(iterations: 1000) { (i) in
            _ = queue.popLock()
        }
    }
}
