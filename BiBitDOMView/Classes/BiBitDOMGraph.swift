//
//  BiBitDOMGuage.swift
//  BiBitDOMView
//


import UIKit
import CoreText


public class BiBitItemLayer: CAShapeLayer {
    fileprivate var textLayer: CATextLayer = {
        let textLayer = CATextLayer()
            textLayer.font = UIFont(name: "Helvetica-Bold", size: 12.0)
            textLayer.fontSize = 12.0
            textLayer.alignmentMode = kCAAlignmentCenter
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.contentsScale = UIScreen.main.scale
        return textLayer
    }()
    
    fileprivate var progressLayer : CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    public var text: NSAttributedString? {
        didSet {
            textLayer.string = text
            //display()
        }
    }
    
    public var progressColor: CGColor? {
        didSet {
            progressLayer.strokeColor = progressColor
            //display()
        }
    }
    
    public var type: BiBitDOMViewType = .none {
        didSet {
            let progressPath = UIBezierPath()
            var x0 = type == .bid ? self.bounds.width : 0.0
            progressPath.move(to: CGPoint(x: x0, y: self.bounds.height / 2))
            x0 = type == .bid ? 0.0 : self.bounds.width
            progressPath.addLine(to: CGPoint(x: x0, y: self.bounds.height / 2))
            progressLayer.path = progressPath.cgPath
            display()
        }
    }
    public var progress: CGFloat = 0.0 {
        didSet {
            progressLayer.strokeEnd = progress
            display()
        }
    }
    
    public override init() {
        super.init()
        self.addSublayer(progressLayer)
        self.addSublayer(textLayer)
        
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
        self.addSublayer(progressLayer)
        self.addSublayer(textLayer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSublayer(progressLayer)
        self.addSublayer(textLayer)
    }
    
    override public func layoutSublayers() {
        super.layoutSublayers()
        self.textLayer.frame = self.bounds
        progressLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width * progress, height: self.bounds.height)
        progressLayer.lineWidth = self.bounds.height
    }
    
}

public class BiBitDOMGraph: UIScrollView {
    public var dataSet: Array<BiBitDOMViewDataSetItemProtocol>? {
        didSet {
            reloadData()
        }
    }
    public var type: BiBitDOMViewType
    
    public func reloadData() {
        setNeedsDisplay()
    }
    
    public init(type: BiBitDOMViewType) {
        
        self.type = type
        super.init(frame: .zero)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        let w: CGFloat = frame.width

        var color: UIColor
        let x0: CGFloat = 0.0
        
        switch self.type {
            case .bid:
                color = UIColor.green
            case .ask:
                color = UIColor.red
            case .none:
                color = .white

        }


        let rowHeight: CGFloat = 14.0
        var row = 0
        let rowCount = dataSet?.count ?? 0

        let textAttr = [ NSAttributedStringKey.font: UIFont(name: "Helvetica-Bold", size: 12.0)! ,
                         NSAttributedStringKey.foregroundColor: UIColor.white ]
        
        while row < rowCount {

            guard let item = dataSet?[row] else { return }
            
            let progress: CGFloat = (CGFloat(item.amount) / CGFloat(item.max))
            
            var textLabel: NSAttributedString

            if type == .ask {
                textLabel = NSAttributedString(string: "\(item.price)\t\t\(String(format: "%.5f", abs(item.amount)))", attributes: textAttr)
            } else {
                textLabel = NSAttributedString(string: "\(String(format: "%.5f", abs(item.amount)))\t\t\(item.price)", attributes: textAttr)
            }
            
            if layer.sublayers != nil && layer.sublayers?.count ?? 0 > row {
                if let sublayers = layer.sublayers, let progressLayer: BiBitItemLayer = sublayers[row] as? BiBitItemLayer {
                    progressLayer.progress = progress
                    progressLayer.text = textLabel
                }
            } else {
                let y0: CGFloat = CGFloat(row) * rowHeight
                
                let progressLayer = BiBitItemLayer()
                    progressLayer.frame = CGRect(x: x0, y: y0, width: w, height: rowHeight)
                    progressLayer.type = self.type
                    progressLayer.progressColor = color.cgColor
                    progressLayer.progress = progress
                    progressLayer.text = textLabel
                
                layer.addSublayer(progressLayer)
            }

            row += 1
        }

        contentSize = CGSize(width: w, height: CGFloat(rowCount) * rowHeight)

    }
}

