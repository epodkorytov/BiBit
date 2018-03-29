//
//  BiBitSheduler.swift
//  BiBitCore
//
//  Created by Evgene Podkorytov on 09.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation

public class BiBitSheduler {
    //MARK: - Private
    fileprivate var _fireInterval: TimeInterval = 0
    fileprivate var timer: Timer?
    
    //MARK: - Public
    public var fireInterval: TimeInterval {
        set {
            _fireInterval = newValue
        }
        get {
            return _fireInterval.isZero ? 1*60.0 : _fireInterval
        }
    }
    public var action: (() -> Void)?
    
    
    public init(){
        
    }
    
    public func start() {
        if let timer = timer {
            if timer.isValid {
                timer.fire()
            }
        } else {
            timer = Timer(fireAt: Date(),
                          interval: fireInterval,
                          target: self,
                          selector: #selector(runAction),
                          userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    public func stop() {
        if timer != nil && timer!.isValid {
            timer!.invalidate()
            timer = nil
        }
    }
    
    @objc private func runAction(){
        action?()
    }
}
