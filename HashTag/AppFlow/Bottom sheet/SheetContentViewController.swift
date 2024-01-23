//
//  SheetContentViewController.swift
//  FittedSheetsPod
//
//  Created by Gordon Tucker on 7/29/20.
//  Copyright © 2020 Gordon Tucker. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit

protocol SheetContentViewDelegate: AnyObject {
    func preferredHeightChanged(oldHeight: CGFloat, newSize: CGFloat)
    func pullBarTapped()
}


public class SheetContentViewController: UIViewController {
    
    public private(set) var childViewController: UIViewController
    
    private var options: SheetOptions
    private (set) var size: CGFloat = 0
    private (set) var preferredHeight: CGFloat
    
    public var contentBackgroundColor: UIColor? {
        get { self.roundedContainerView.backgroundColor }
        set { self.roundedContainerView.backgroundColor = newValue }
    }
    weak var delegate: SheetContentViewDelegate?
    
    public var contentView = UIView()
    private var contentTopConstraint: NSLayoutConstraint?
    private var contentBottomConstraint: NSLayoutConstraint?
    private var navigationHeightConstraint: NSLayoutConstraint?
    public var roundedContainerView = UIView()
    public var pullBarView: UIView?
    public var gripView: UIView?
    
    public init(childViewController: UIViewController, options: SheetOptions) {
        self.options = options
        self.childViewController = childViewController
        self.preferredHeight = 0
        super.init(nibName: nil, bundle: nil)
        
        if options.setIntrensicHeightOnNavigationControllers, let navigationController = self.childViewController as? UINavigationController {
            navigationController.delegate = self
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupContentView()
        self.setupRoundedContainerView()
        self.setupPullBarView()
        self.setupChildViewController()
        self.updatePreferredHeight()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.performWithoutAnimation {
            self.view.layoutIfNeeded()
        }
        self.updatePreferredHeight()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updatePreferredHeight()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateAfterLayout()
    }
    
    func updateAfterLayout() {
        self.size = self.childViewController.view.bounds.height
        //self.updatePreferredHeight()
    }
    
    func adjustForKeyboard(height: CGFloat) {
        self.updateChildViewControllerBottomConstraint(adjustment: -height)
    }
    
    private func updateNavigationControllerHeight() {
        // UINavigationControllers don't set intrensic size, this is a workaround to fix that
        guard self.options.setIntrensicHeightOnNavigationControllers, let navigationController = self.childViewController as? UINavigationController else { return }
        self.navigationHeightConstraint?.isActive = false
        self.contentTopConstraint?.isActive = false
        
        if let viewController = navigationController.visibleViewController {
           let size = viewController.view.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0))
        
            if self.navigationHeightConstraint == nil {
                self.navigationHeightConstraint = navigationController.view.heightAnchor.constraint(equalToConstant: size.height)
            } else {
                self.navigationHeightConstraint?.constant = size.height
            }
        }
        self.navigationHeightConstraint?.isActive = true
        self.contentTopConstraint?.isActive = true
    }
    
    func updatePreferredHeight() {
        self.updateNavigationControllerHeight()
        let width = self.view.bounds.width > 0 ? self.view.bounds.width : UIScreen.main.bounds.width
        let oldPreferredHeight = self.preferredHeight
        var fittingSize = UIView.layoutFittingCompressedSize;
        fittingSize.width = width;
        
        self.contentTopConstraint?.isActive = false
        UIView.performWithoutAnimation {
            self.contentView.layoutSubviews()
        }
        
        self.preferredHeight = self.contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow).height
        self.contentTopConstraint?.isActive = true
        UIView.performWithoutAnimation {
            self.contentView.layoutSubviews()
        }
        
        self.delegate?.preferredHeightChanged(oldHeight: oldPreferredHeight, newSize: self.preferredHeight)
    }
    
    private func updateChildViewControllerBottomConstraint(adjustment: CGFloat) {
        self.contentBottomConstraint?.constant = adjustment
    }
    
    private func setupChildViewController() {
        self.childViewController.willMove(toParent: self)
        self.addChild(self.childViewController)
        self.roundedContainerView.addSubview(self.childViewController.view)
        Constraints(for: self.childViewController.view) { view in
            view.left.pinToSuperview()
            view.right.pinToSuperview()
            self.contentBottomConstraint = view.bottom.pinToSuperview()
                view.top.pinToSuperview()
        }
        if self.options.shouldExtendBackground, self.options.pullBarHeight > 0 {
            if #available(iOS 11.0, *) {
                self.childViewController.additionalSafeAreaInsets = UIEdgeInsets(top: self.options.pullBarHeight, left: 0, bottom: 0, right: 0)
            } else {
                // Fallback on earlier versions
            }
        }
        
        self.childViewController.didMove(toParent: self)
    }

    private func setupContentView() {
        self.view.addSubview(self.contentView)
        Constraints(for: self.contentView) {
            $0.left.pinToSuperview()
            $0.right.pinToSuperview()
            $0.bottom.pinToSuperview()
            self.contentTopConstraint = $0.top.pinToSuperview()
        }
    }
    
    private func setupRoundedContainerView() {
        self.contentView.addSubview(self.roundedContainerView)
        
        Constraints(for: self.roundedContainerView) { view in
            
            if self.options.shouldExtendBackground {
                view.top.pinToSuperview()
            } else {
                view.top.pinToSuperview(inset: self.options.pullBarHeight)
            }
            view.left.pinToSuperview()
            view.right.pinToSuperview()
            view.bottom.pinToSuperview()
        }
        
        if self.options.cornerRadius > 0 {
            self.roundedContainerView.layer.cornerRadius = self.options.cornerRadius
            self.roundedContainerView.layer.masksToBounds = true
            if #available(iOS 11.0, *) {
                self.roundedContainerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private func setupPullBarView() {
        // If they didn't specify pull bar options, they don't want a pull bar
        guard self.options.pullBarHeight > 0 else { return }
        let pullBarView = UIView()
        pullBarView.isUserInteractionEnabled = true
        pullBarView.backgroundColor = .clear
        self.contentView.addSubview(pullBarView)
        Constraints(for: pullBarView) {
            $0.top.pinToSuperview()
            $0.left.pinToSuperview()
            $0.right.pinToSuperview()
            $0.height.set(options.pullBarHeight)
        }
        self.pullBarView = pullBarView
        
        let gripView = UIView()
        gripView.backgroundColor = options.gripColor
        gripView.layer.cornerRadius = options.gripSize.height / 2
        gripView.layer.masksToBounds = true
        pullBarView.addSubview(gripView)
        Constraints(for: gripView) {
            $0.centerY.alignWithSuperview()
            $0.centerX.alignWithSuperview()
            $0.size.set(options.gripSize)
        }
        
        pullBarView.isAccessibilityElement = true
        pullBarView.accessibilityIdentifier = "pull-bar"
        // This will be overriden whenever the sizes property is changed on SheetViewController
        pullBarView.accessibilityLabel = Localize.dismissPresentation.localized
        pullBarView.accessibilityTraits = [.button]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pullBarTapped))
        pullBarView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func pullBarTapped(_ gesture: UITapGestureRecognizer) {
        self.delegate?.pullBarTapped()
    }
}

extension SheetContentViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.view.endEditing(true)
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.navigationHeightConstraint?.isActive = true
        self.updatePreferredHeight()
    }
}

#endif // os(iOS) || os(tvOS) || os(watchOS)
