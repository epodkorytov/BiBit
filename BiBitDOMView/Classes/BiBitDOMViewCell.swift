//
//  BiBitDOMViewCell.swift
//  BiBitDOMView
//

import UIKit



public class BiBitDOMViewCell: UITableViewCell {
    fileprivate let progress = CAShapeLayer()
    
    public var type: BiBitDOMViewPageType = .none {
        didSet {
            setupType()
        }
    }
    public var item: BiBitDOMViewDataSetItemProtocol? {
        didSet {
            let p = CGFloat(Double((item?.amount)!) / Double((item?.max)!))
            progress.strokeEnd = p
            textLabel?.text = "\(String(format: "%d", (item?.price)!)), \(String(format: "%.5f",  (item?.amount)!)), \(String(format: "%.2f", p))"
        }
    }
    
    
    //MARK: - Overriden methods
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        progress.strokeEnd = 0.0
        
    }
    
    deinit {
        item = nil
    }
    
    private func createProgress() {
        progress.path = UIBezierPath(rect: frame).cgPath
        progress.backgroundColor = UIColor.clear.cgColor
        progress.fillColor = nil
        progress.strokeColor = nil
        progress.lineWidth = frame.height
        progress.strokeStart = 0.0
        progress.strokeEnd = 0.0
        
        textLabel?.layer.addSublayer(progress)
    }
    
    fileprivate func setupType() {
        switch self.type {
        case .bid:
            progress.strokeColor = UIColor.green.cgColor
            textLabel?.textAlignment = .right
        case .ask:
            progress.strokeColor = UIColor.red.cgColor
            textLabel?.textAlignment = .left
        case .none:
            backgroundColor = .white
            
        }
    }
    
    fileprivate func setupUI() {
        accessoryType = .none
        selectionStyle = .none
        textLabel?.font = UIFont(name: "Helvetica", size: 8)
        textLabel?.backgroundColor = .clear
        
        createProgress()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
