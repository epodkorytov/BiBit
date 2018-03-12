//
//  ViewController.swift
//  BiBit
//
//  Created by Evgene Podkorytov on 07.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import UIKit
import BiBitCore
import BiBitDOMView

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let domView = BiBitDOMView()
        
        
        BiBitCore.shared.service?.connect()
        
        BiBitCore.shared.service?.didUpdated = {
            //print("DOM updated => bid.max is \(String(format: "%.5f", (BiBitCore.shared.service?.dom.maxBid)!)), bid.cnt is \(String(describing: BiBitCore.shared.service?.dom.bid.count)), ask.max is \(String(format: "%.5f", (BiBitCore.shared.service?.dom.maxAsk)!)), ask.cnt is \(String(describing: BiBitCore.shared.service?.dom.ask.count))")
            
            let maxBid = BiBitCore.shared.service?.dom.maxBid
            let bid = BiBitCore.shared.service?.dom.bid.flatMap({ return BiBitDOMViewDataSetItem(price: $0.price, amount: $0.amount, max: maxBid!)})
            
            let maxAsk = BiBitCore.shared.service?.dom.maxAsk
            let ask = BiBitCore.shared.service?.dom.ask.flatMap({ return BiBitDOMViewDataSetItem(price: $0.price, amount: $0.amount, max: maxAsk!)})
            
            domView.dataSet = BiBitDOMViewDataSet(bid: bid!, ask: ask!)
        }
        
        view = domView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

