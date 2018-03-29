//
//  BiBitModels.swift
//  BiBitCore
//
//  Created by Evgene Podkorytov on 09.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation

public class OBItem: Codable {
    public var price: Int
    public var amount: Double
    
    public init(price: Int, amount: Double){
        self.price = price
        self.amount = amount
    }
}

public class Dom {
    public var items: Array<OBItem>
    
    public var bid: Array<OBItem>? { return items.filter({$0.amount >= 0.0}).sorted{ $0.amount <= $1.amount} }
    public var ask: Array<OBItem>? { return items.filter({$0.amount < 0.0}).sorted{ $0.amount >= $1.amount} }
    
    public var maxBid: Double {
        guard let amount = items.max(by: {$0.amount <= $1.amount})?.amount else { return 0 }
        return amount
    }
    
    public var maxAsk: Double {
        guard let amount = items.min(by: {$0.amount < $1.amount})?.amount else { return 0 }
        return amount
    }
    
    public var didUpdated: (() -> Void)?
    
    fileprivate var domLoaded: Bool
    
    public init(){
        self.items = Array<OBItem>()
        domLoaded = false
    }
    
    public func update(_ items: Array<OBItem>) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            DispatchQueue.main.async {
                for item in items {
                    if let idx = self.items.index(where: { $0.price == item.price }) {
                        self.items[idx] = item
                    } else if !self.domLoaded {
                        self.items.append(item)
                    }
                }
                
                self.domLoaded = true
            }
            self.didUpdated?()
        }
    }
}
