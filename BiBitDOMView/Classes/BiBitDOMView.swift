//
//  BiBitDOMView.swift
//  BiBitDOMView
//
import UIKit

public enum BiBitDOMViewType: Int {
    case none = -1
    case bid
    case ask
}

public class BiBitDOMView: UIView {
    public var dataSet: BiBitDOMViewDataSetProtocol? {
        didSet{
            //print("bid: \(String(describing: dataSet?.bid.count)) items, ask: \(String(describing: dataSet?.ask.count)) items")
            reloadData()
        }
    }
    
    fileprivate var bidView: BiBitDOMGraph = BiBitDOMGraph(type: .bid)
    fileprivate var askView: BiBitDOMGraph = BiBitDOMGraph(type: .ask)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        bidView.translatesAutoresizingMaskIntoConstraints = false
        askView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bidView)
        addSubview(askView)
        
        bidView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bidView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bidView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bidView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
        askView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        askView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        askView.leadingAnchor.constraint(equalTo: bidView.trailingAnchor).isActive = true
        askView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    public func reloadData() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async{
            if let bid = self.dataSet?.bid {
                DispatchQueue.main.async {
                    self.bidView.dataSet = bid
                }
            }
            if let ask = self.dataSet?.ask {
                DispatchQueue.main.async {
                    self.askView.dataSet = ask
                }
            }
        }
        
        
    }
}

//public class BiBitDOMViewFlowLayout: UICollectionViewFlowLayout {
//    override public init() {
//        super.init()
//        minimumInteritemSpacing = 1
//        minimumLineSpacing = 0
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//public class BiBitDOMView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    public var dataSet: BiBitDOMViewDataSetProtocol? {
//        didSet{
//            print("bid: \(dataSet?.bid.count) items, ask: \(dataSet?.ask.count) items")
//            reloadData()
//        }
//    }
//
//
//    public init(){
//        super.init(frame: .zero, collectionViewLayout: BiBitDOMViewFlowLayout())
//
//        backgroundColor = .white
//        showsHorizontalScrollIndicator = false
//        register(BiBitDOMViewPage.self, forCellWithReuseIdentifier: "Page")
//        delegate = nil
//        dataSource = nil
//    }
//
//    required public init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    public override func reloadData() {
//        delegate = self
//        dataSource = self
//        super.reloadData()
//    }
//    // MARK: UICollectionViewDelegate
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 2
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let page = collectionView.dequeueReusableCell(withReuseIdentifier: "Page", for: indexPath) as! BiBitDOMViewPage
//            page.type = BiBitDOMViewPageType(rawValue: indexPath.item) ?? .none
//
//        if let dataSet = dataSet {
//            switch indexPath.item {
//                case 0:
//                    page.dataSet = dataSet.bid
//                case 1:
//                    page.dataSet = dataSet.ask
//                default:
//                    page.dataSet = []
//            }
//        }
//
//        return page
//    }
//    // MARK: UICollectionViewDelegateFlowLayout
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width/2 - 0.5, height: frame.height)
//    }
//
//}

