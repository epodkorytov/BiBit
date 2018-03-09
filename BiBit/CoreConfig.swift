//
//  CoreConfig.swift
//  BiBit
//
//  Created by Evgene Podkorytov on 08.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation
import BiBitCore


struct DefaultServiceAddress: ServiceAddressProtocol {
    var domain: String = "front-test-1.herokuapp.com"
    var path: String? = "ob"
    var params: Array<(param: String, value:String)>? = [(param: "key", value: "210c01fe-1962-40f8-8730-f8387c321090"), (param: "rate", value: "2000")]
    var isSecureSocket: Bool = true
    
    public init() {}
}

struct DefaultCoreConfig: BiBitCoreConfigProtocol {
    public var service: ServiceAddressProtocol = DefaultServiceAddress()
    public var sleepTime: TimeInterval = 10
    
    public init() {}
}
