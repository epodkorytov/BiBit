//
//  BiBitCore.swift
//  BiBitCore
//
//  Created by Evgene Podkorytov on 07.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation




public class BiBitCore {
    public static let shared = BiBitCore()
    
    //MARK: - Private
    fileprivate var sheduler: BiBitSheduler?
    
    //MARK: - Public
    public var service: BiBitService?
    
    
    
    public init(){
        
    }
    
    
}
