//
//  main.swift
//  MaxConcurrentTaskQueueSwift
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

import Foundation

let maxConcurrency = 5
let taskCount = 100
let sleepFor: NSTimeInterval = 2

print("Hello, World!")

let q = MaxConcurrentTasksQueue(withMaxConcurrency: maxConcurrency);
let group = dispatch_group_create()

for i in 1...100 {
    dispatch_group_enter(group);
    q.enqueue {
        print("Task:", i);
        if (sleepFor > 0) {
            NSThread.sleepForTimeInterval(sleepFor);
        }
        dispatch_group_leave(group);
    }
}

dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

print("Goodbye, World");

