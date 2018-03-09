//
//  ViewController.swift
//  BiBit
//
//  Created by Evgene Podkorytov on 07.03.2018.
//  Copyright © 2018 iEvgen Podkorytov. All rights reserved.
//

import UIKit
import BiBitCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        BiBitCore.shared.service?.connect()
        
        BiBitCore.shared.service?.didUpdated = {
            print("DOM updated => bid.max is \(String(format: "%.5f", (BiBitCore.shared.service?.dom.maxBid)!)), bid.cnt is \(String(describing: BiBitCore.shared.service?.dom.bid.count)), ask.max is \(String(format: "%.5f", (BiBitCore.shared.service?.dom.maxAsk)!)), ask.cnt is \(String(describing: BiBitCore.shared.service?.dom.ask.count))")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

