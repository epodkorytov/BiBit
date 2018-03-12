//
//  BiBitDOMView.swift
//  BiBitDOMView
//
import UIKit

public class BiBitDOMViewFlowLayout: UICollectionViewFlowLayout {
    override public init() {
        super.init()
        minimumInteritemSpacing = 1
        minimumLineSpacing = 0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class BiBitDOMView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public var dataSet: BiBitDOMViewDataSetProtocol? {
        didSet{
            print("bid: \(dataSet?.bid.count) items, ask: \(dataSet?.ask.count) items")
            reloadData()
        }
    }
    
    
    public init(){
        super.init(frame: .zero, collectionViewLayout: BiBitDOMViewFlowLayout())
        
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        register(BiBitDOMViewPage.self, forCellWithReuseIdentifier: "Page")
        delegate = nil
        dataSource = nil
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func reloadData() {
        delegate = self
        dataSource = self
        super.reloadData()
    }
    // MARK: UICollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let page = collectionView.dequeueReusableCell(withReuseIdentifier: "Page", for: indexPath) as! BiBitDOMViewPage
            page.type = BiBitDOMViewPageType(rawValue: indexPath.item) ?? .none
        
        if let dataSet = dataSet {
            switch indexPath.item {
                case 0:
                    page.dataSet = dataSet.bid
                case 1:
                    page.dataSet = dataSet.ask
                default:
                    page.dataSet = []
            }
        }
        
        return page
    }
    // MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2 - 0.5, height: frame.height)
    }
    
}
