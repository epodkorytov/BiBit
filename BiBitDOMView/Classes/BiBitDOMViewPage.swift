//
//  BiBitDOMViewPage.swift
//  BiBitDOMView
//

import UIKit

public enum BiBitDOMViewPageType: Int {
    case none = -1
    case bid
    case ask
}

public class BiBitDOMViewPage: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    public var type: BiBitDOMViewPageType = .none {
        didSet {
            setupType()
        }
    }
    
    public var dataSet: Array<BiBitDOMViewDataSetItemProtocol> = [] {
        didSet {
            table.dataSource = nil
            table.delegate = nil
            
            reloadData()
        }
    }
    
    fileprivate var table = UITableView()
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        table = UITableView(frame: .zero, style: UITableViewStyle.plain)
        table.registerCell(BiBitDOMViewCell.self)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    public func reloadData(){
        table.dataSource = self
        table.delegate = self
        table.reloadData()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(table)
        table.topAnchor.constraint(equalTo: topAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    fileprivate func setupType() {
        
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        table.dataSource = self
        table.delegate = self
        table.layoutIfNeeded()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 12
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSet[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(BiBitDOMViewCell.self)
            cell?.item = item
            cell?.type = type
        return cell!
    }
}
