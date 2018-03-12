//
//  BiBitModels.swift
//  BiBitCore
//
//  Created by Evgene Podkorytov on 09.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation

public struct OBItem: Codable {
    public var price: Int = 0
    public var amount: Double = 0.0
}

public class Dom {
    public var items: Array<OBItem>
    
    public var bid: Array<OBItem> { return items.filter({$0.amount >= 0.0}).sorted{ $0.amount <= $1.amount} }
    public var ask: Array<OBItem> { return items.filter({$0.amount < 0.0}).sorted{ $0.amount >= $1.amount} }
    public var maxBid: Double { return items.max(by: {$0.amount <= $1.amount})?.amount ?? 0}
    public var maxAsk: Double { return items.min(by: {$0.amount < $1.amount})?.amount ?? 0}
    
    public var didUpdated: (() -> Void)?
    
    public init(){
        self.items = Array<OBItem>()
    }
    
    public func update(_ items: Array<OBItem>) {
        for item in items {
            if let idx = self.items.index(where: { $0.price == item.price }) {
                self.items[idx] = item
            } else {
                self.items.append(item)
            }
        }
        
        self.items = self.items.sorted(by: {$0.price > $1.price})
        //
        
        self.didUpdated?()
    }
}
