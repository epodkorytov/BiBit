////
////  BiBitDOMViewPage.swift
////  BiBitDOMView
////
//
//import UIKit
//
//
//
//public class BiBitDOMViewPage: UICollectionViewCell {
//    
//    public var type: BiBitDOMViewType = .none {
//        didSet {
//            setupType()
//        }
//    }
//    
//    public var dataSet: Array<BiBitDOMViewDataSetItemProtocol> = [] {
//        didSet {
//            reloadData()
//        }
//    }
//    
//    fileprivate var graph = BiBitDOMGraph()
//    
//    public override init(frame: CGRect) {
//        super.init(frame: .zero)
//        
//        setupUI()
//    }
//    
//    public func reloadData(){
//        graph.dataSet = dataSet
//    }
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    fileprivate func setupUI() {
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        graph.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(graph)
//        graph.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        graph.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        graph.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        graph.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        
//    }
//    
//    fileprivate func setupType() {
//        graph.type = type
//    }
//    
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        
//        
//    }
//    
//}

