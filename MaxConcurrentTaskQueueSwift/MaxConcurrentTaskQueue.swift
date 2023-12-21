//
//  MaxConcurrentTasksQueueSwift.swift
//  MaxConcurrencyGCD
//
//  Created by Michael Rhodes on 04/06/2016.
//  Copyright © 2016 Michael Rhodes.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file
//  except in compliance with the License. You may obtain a copy of the License at
//    http://www.apache.org/licenses/LICENSE-2.0
//  Unless required by applicable law or agreed to in writing, software distributed under the
//  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
//  either express or implied. See the License for the specific language governing permissions
//  and limitations under the License.
//

import Cocoa

class MaxConcurrentTasksQueue: NSObject {
    
    private let serialq: DispatchQueue
    private let concurrentq: DispatchQueue
    private let sema: DispatchSemaphore
    
    init(withMaxConcurrency maxConcurrency: Int) {
        serialq = DispatchQueue.init(label: "uk.co.dx13.serial")
        concurrentq = DispatchQueue.init(label: "uk.co.dx13.concurrent", attributes: .concurrent)
        sema = DispatchSemaphore(value: maxConcurrency);
    }
    
    func enqueue(task: @escaping () -> ()) {
        serialq.async() {
            _ = self.sema.wait(timeout: DispatchTime.distantFuture)
            self.concurrentq.async() {
                task();
                self.sema.signal();
            }
        }; 
    }

    
}
