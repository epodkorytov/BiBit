//
//  BiBitCoreConfig.swift
//  BiBitCore
//
//  Created by Evgene Podkorytov on 08.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation

public typealias Param = (param: String, value: String)
public typealias Params = Array<Param>

public extension Sequence where Iterator.Element == Param {
    public var absoluteString: String {
        return self.map({"\($0.param)=\($0.value)"}).joined(separator: "&")
    }
}

public protocol ServiceAddressProtocol {
    var domain: String { get set }
    var path: String? { get set }
    var params: Params? { get set }
    var isSecureSocket: Bool { get set }
}

public extension ServiceAddressProtocol {
    public var url: URL {
        let protocolURL = isSecureSocket ? "wss" : "ws"
        var fullPath = "\(protocolURL)://\(self.domain)"
        
        if let path = self.path {
            fullPath.append("/")
            fullPath.append("\(path)")
        }
        
        if let params = params?.absoluteString {
            fullPath.append("?")
            fullPath.append("\(params)")
        }
        
        return URL(string: fullPath)!
    }
}

public struct ServiceAddress: ServiceAddressProtocol {
    public var domain: String
    public var path: String?
    public var params: Params?
    public var isSecureSocket: Bool
}

public protocol BiBitCoreConfigProtocol {
    var service: ServiceAddressProtocol { get set }
    var sleepTime: TimeInterval { get set }
}

public struct BiBitCoreConfig: BiBitCoreConfigProtocol {
    public var service: ServiceAddressProtocol
    public var sleepTime: TimeInterval
    
}
