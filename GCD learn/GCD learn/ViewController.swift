//
//  ViewController.swift
//  GCD learn
//
//  Created by 張書涵 on 2018/8/31.
//  Copyright © 2018年 AliceChang. All rights reserved.
//
import UIKit

class GCDSemaphore:UIViewController {
    
    // MARK: 变量
    fileprivate var dispatchSemaphore : DispatchSemaphore!
    
    
    // MARK: 初始化
    public init() {
        
        dispatchSemaphore = DispatchSemaphore(value: 0)
    }
    
    public init(withValue : Int) {
        
        dispatchSemaphore = DispatchSemaphore(value: withValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 执行
    public func signal() -> Bool {
        
        return dispatchSemaphore.signal() != 0
    }
    
    public func wait() {
        
        _ = dispatchSemaphore.wait(timeout: DispatchTime.distantFuture)
    }
    
    public func wait(timeoutNanoseconds : DispatchTimeInterval) -> Bool {
        
        if dispatchSemaphore.wait(timeout: DispatchTime.now() + timeoutNanoseconds) == DispatchTimeoutResult.success {
            
            return true
        }else {
            
            return false
        }
    }
}
