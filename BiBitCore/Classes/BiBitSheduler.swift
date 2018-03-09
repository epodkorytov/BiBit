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
    
    //MARK: - Public
    public var fireInterval: TimeInterval {
        set {
            _fireInterval = newValue
        }
        get {
            return _fireInterval.isZero ? 10*60.0 : _fireInterval
        }
    }
    
    
    
    public init(){
        
    }
}
