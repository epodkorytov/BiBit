//
//  BiBitDOMViewDataSet.swift
//  BiBitDOMView
//
//  Created by Evgene Podkorytov on 11.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import Foundation

public protocol BiBitDOMViewDataSetItemProtocol {
    var price: Int { get set }
    var amount: Double { get set }
    var max: Double { get set }
}


public struct BiBitDOMViewDataSetItem: BiBitDOMViewDataSetItemProtocol {
    public var max: Double
    public var price: Int
    public var amount: Double
    
    public init(price: Int, amount: Double, max: Double) {
        self.price = price
        self.amount = amount
        self.max = max
    }
}

public typealias BiBitDOMViewDS = Array<BiBitDOMViewDataSetItemProtocol>

public protocol BiBitDOMViewDataSetProtocol {
    var bid: Array<BiBitDOMViewDataSetItemProtocol> { get set }
    var ask: Array<BiBitDOMViewDataSetItemProtocol> { get set }
}

public class BiBitDOMViewDataSet: BiBitDOMViewDataSetProtocol {
    public var bid: BiBitDOMViewDS
    public var ask: BiBitDOMViewDS
    
    public init(bid: BiBitDOMViewDS, ask: BiBitDOMViewDS) {
        self.bid = bid
        self.ask = ask
    }
}
