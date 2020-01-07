//
//  UIView+Xib.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 07/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

protocol ViewFromXib {
    func loadContentView(name: String?, byMergins: Bool) -> UIView?
    static var nibName: String? { get }
}

extension ViewFromXib {
    func loadContentView(name: String?) -> UIView? {
        return loadContentView(name: name, byMergins: false)
    }
}

extension ViewFromXib where Self: UIView {
    static var nibName: String? {
        return nil
    }
    
    @discardableResult
    func loadContentView(name: String? = nil, byMergins: Bool = false) -> UIView? {
        guard let contentView = loadViewFromNib(name: name) else {
            return nil
        }
        
        contentView.backgroundColor = backgroundColor
        contentView.frame = bounds
        
        if byMergins {
            placeMargins(contentView)
        } else {
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(contentView, at: 0)
        }
        
        return contentView
    }
    
    private func loadViewFromNib(name: String?) -> UIView? {
        let name = Self.nibName ?? String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
