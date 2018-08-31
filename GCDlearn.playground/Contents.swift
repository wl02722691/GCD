//: Playground - noun: a place where people can play


import Foundation

let globalDefault = DispatchQueue.global()
let sem = DispatchSemaphore(value: 2)

// 信号量将被两个线程池组持有
globalDefault.sync {
    DispatchQueue.concurrentPerform(iterations: 10) { (id:Int) in
        sem.wait(timeout: DispatchTime.distantFuture)
        sleep(1)
        print(String(id)+" acquired semaphore.")
        sem.signal()
    }
}
