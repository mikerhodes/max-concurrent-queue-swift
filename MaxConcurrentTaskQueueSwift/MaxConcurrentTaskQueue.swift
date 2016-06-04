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
    
    private let serialq: dispatch_queue_t
    private let concurrentq: dispatch_queue_t
    private let sema: dispatch_semaphore_t
    
    init(withMaxConcurrency maxConcurrency: Int) {
        serialq = dispatch_queue_create("uk.co.dx13.serial", nil)
        concurrentq = dispatch_queue_create("uk.co.dx13.concurrent", DISPATCH_QUEUE_CONCURRENT)
        sema = dispatch_semaphore_create(maxConcurrency);
    }
    
    func enqueue(task: () -> ()) {
        dispatch_async(serialq) {
            dispatch_semaphore_wait(self.sema, DISPATCH_TIME_FOREVER);
            dispatch_async(self.concurrentq) {
                task();
                dispatch_semaphore_signal(self.sema);
            }
        }; 
    }
    
}
