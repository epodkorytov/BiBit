//
//  BiBitService.swift
//  BiBitCore
//
//  Created by Evgene Podkorytov on 08.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation


public class BiBitService {
    //MARK: - Private
    fileprivate var config: BiBitCoreConfigProtocol
    fileprivate var socket: WebSocket
    
    //MARK: - Public
    public var dom = Dom()
    
    public var didUpdated: (() -> Void)?
    public var lastDate: Date?
    
    public var didConnected: (() -> Void)?
    public var didDisconnected: (() -> Void)?
    public var onError: ((Error) -> Void)?
    
    public init(config: BiBitCoreConfigProtocol){
        self.config = config
        
        //init webSocket
        let request = URLRequest(url: config.service.url)
        socket = WebSocket(request: request)
        
        socketSetUp()
        domSetUp()
    }
    
    fileprivate func socketSetUp() {
        socket.compression.on = true
        socket.services = [.Background]
        
        //
        socket.event.open = {
            self.didConnected?()
        }
        
        //
        socket.event.close = { code, reason, clean in
            self.didDisconnected?()
            self.socket.ping()
        }
        
        //
        socket.event.error = { error in
            self.onError?(error)
        }
        
        
        //
        socket.event.message = { message in
            if let message = message as? String {
                self.messageReceive(message)
            }
        }
    }
    
    fileprivate func domSetUp(){
        self.dom.didUpdated = {
            self.didUpdated?()
        }
    }
    
    public func connect(){
        socket.open()
        socket.ping()
    }
    
    public func ping(){
        socket.ping()
    }
    
    public func disconnect(){
        socket.close()
    }
    
    fileprivate func messageReceive(_ message: String) {
        //print("reseive => \(message)")
        
        let stack = message.split { separator -> Bool in
            return separator == "[" || separator == "]"
        }
        
        var items = Array<OBItem>()
        
        items = stack.compactMap { item -> OBItem? in
            let args = item.split(separator: ",")
            if let price = Int(args.first.map({String($0)})!), let amount = Double(args.last.map({String($0)})!) {
                return OBItem(price: price, amount: amount)
            }
            return nil
        }
        
        if !items.isEmpty {
            self.dom.update(items)
            self.lastDate = Date()
        }
    }
}
