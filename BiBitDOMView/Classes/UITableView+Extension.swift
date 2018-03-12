//
//  UITableView+Extension.swift
//  BiBitDOMView
//

import UIKit

public extension UITableView {
    
    public func registerCell<T:UITableViewCell>(_ type: T.Type){
        self.register(T.self, forCellReuseIdentifier: cellReuseIdentifier(T.self))
    }
    
    public func dequeueReusableCell<T:UITableViewCell>(_ type: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: cellReuseIdentifier(T.self)) as? T
    }
    
    public func dequeueReusableCell<T:UITableViewCell>(_ type: T.Type, forIndexPath indexPath:IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: cellReuseIdentifier(T.self), for: indexPath) as? T
    }
    
    public func cellReuseIdentifier<T:UITableViewCell>(_ type: T.Type) -> String {
        var fullName: String = NSStringFromClass(T.self)
        if let name = fullName.split(separator: ".").last {
            fullName = String(name)
        }
        return fullName
    }
    
    public func reloadData(_ completion: @escaping ()->()) {
        self.reloadData()
        
        DispatchQueue.main.async {
            completion()
        }
    }
}
