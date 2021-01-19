//
//  MyQueue.swift
//  Example
//
//  Created by admin on 1/5/21.
//

import Foundation

class Queue<T> {
    private var elements: [T] = []
    let lock = NSLock()
    let queueSerial = DispatchQueue(label: "dispatchqueueserial")
    let queueConcurrent = DispatchQueue(label: "dispatchqueueconcurrent", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)
    func pushDispatch(_ element: T) {
        queueSerial.sync {
            self.elements.append(element)
        }
            
    }
    
    func popDispatch() -> T? {
        queueSerial.sync {
            if self.elements.isEmpty {
                return nil
            }
            
            return self.elements.removeFirst()
        }
    }
    
    func pushSemaphore(_ element: T) {
        queueConcurrent.async {
            self.semaphore.wait()
            self.elements.append(element)
            self.semaphore.signal()
        }
        
    }
    
    func popSemaphore() -> T? {
        queueConcurrent.sync {
            if self.elements.isEmpty {
                return nil
            }
            return self.elements.removeFirst()
        }
    }
    
    func pushLock(_ element: T) {
        lock.lock(); defer {lock.unlock()}
        self.elements.append(element)
    }
    
    func popLock() -> T? {
        lock.lock(); defer {lock.unlock()}
        if self.elements.isEmpty {
            return nil
        }
        return self.elements.removeFirst()
    }
}
