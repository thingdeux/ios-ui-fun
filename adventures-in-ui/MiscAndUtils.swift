import UIKit

/// Dispatch on global queue after delay in seconds. Priority Default. Pass unowned self or weak object on capture list.
func dispatchOnGlobalQueue(seconds seconds: Double, dispatchBlock: () -> Void) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
    dispatch_after(delayTime, dispatch_get_global_queue(priority, 0), dispatchBlock)
}

/// Dispatch on custom queue after delay in seconds. Priority Default. Pass unowned self or weak object on capture list.
func dispatchOnCustomQueue(seconds seconds: Double, queue: dispatch_queue_t, dispatchBlock: () -> Void) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, queue, dispatchBlock)
}

/// Dispatch on main queue after delay in seconds. Priority Default. Pass unowned self or weak object on capture list.
func dispatchOnMainQueue(seconds seconds: Double, dispatchBlock: () -> Void) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue(), dispatchBlock)
}
