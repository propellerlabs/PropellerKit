//
//  ViewNibNestable.swift
//  PropellerKit
//
//  Created by RGfox on 2/7/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit


/// Requires conforming type to inherit from UIView
/// Reusing nib files read more: http://cocoanuts.mobi/2014/03/26/reusable/
///
///
/// When using with view on .xib file `File's Owner` should be the target subclass
/// while the root view in the hierachy should be of class `UIView`
///
///
/// - Usage Instructions:
///    1) add protocol `ViewNibNestable` to UIView
///    2) Call reuseView() in initializer
///
///
/// - Implement with below:
///
/// ```swift
/// required init?(coder aDecoder: NSCoder) {
///    super.init(coder: aDecoder)
///    reuseView()
/// }
/// ```
public protocol ViewNibNestable {
    /// call this function inside `required init?(coder aDecoder: NSCoder)`
    /// of your `UIView` subclass
    func reuseView()
}

extension ViewNibNestable where Self: UIView {
    /// call this function inside `required init?(coder aDecoder: NSCoder)`
    /// of your `UIView` subclass
    func reuseView() {
        reuseViewWithClass(classNamed: Self.self)
    }
    
    private func reuseViewWithClass(classNamed: UIView.Type) {
        let nibName = String(describing: classNamed)
        guard let nibViews = Bundle.main.loadNibNamed(nibName,
                                                      owner: self,
                                                      options: [:]) as? [UIView] else {
                                                        return
        }
        guard let loadedView = nibViews.first else {
            return
        }
        self.addSubview(loadedView)
        loadedView.translatesAutoresizingMaskIntoConstraints = false
        loadedView.boundInside(superview: self)
    }
}

extension ViewNibNestable where Self: UIViewController {
    /// call this function inside `required init?(coder aDecoder: NSCoder)`
    /// of your `UIView` subclass
    public func reuseView() {
        reuseViewWithClass(classNamed: Self.self)
    }
    
    private func reuseViewWithClass(classNamed: UIViewController.Type) {
        let nibName = String(describing: classNamed)
        guard let nibViews = Bundle.main.loadNibNamed(nibName, owner: self, options: [:]) as? [UIView] else {
            return
        }
        guard let loadedView = nibViews.first else {
            return
        }
        view.addSubview(loadedView)
        loadedView.translatesAutoresizingMaskIntoConstraints = false
        loadedView.boundInside(superview: view)
    }
}
