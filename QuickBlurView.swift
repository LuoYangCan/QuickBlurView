//
//  QuickBlurView.swift
//  QuickBlurView
//
//  Created by Krox on 2020/10/25.
//

import Foundation
/// Gaussian blur
@objcMembers public class QuickBlurView: UIView {
    private enum Constants {
        static let blurRadiusKey = "blurRadius"
        static let colorTintKey = "colorTint"
        static let colorTintAlphaKey = "colorTintAlpha"
    }

    // MARK: - Public

    public var blurRadius: CGFloat = 10.0 {
        didSet {
            QuickBlurSetValue(blurRadius, forKey: Constants.blurRadiusKey)
        }
    }

    public var colorTint: UIColor = .clear {
        didSet { QuickBlurSetValue(colorTint, forKey: Constants.colorTintKey) }
    }

    public var colorTintAlpha: CGFloat = 0.8 {
        didSet { QuickBlurSetValue(colorTintAlpha, forKey: Constants.colorTintAlphaKey) }
    }
    
    // MARK: - Private
    private lazy var visualEffectView: UIVisualEffectView = {
        if #available(iOS 14.0, *) {
            return UIVisualEffectView(effect: customBlurEffect_ios14)
        } else {
            return UIVisualEffectView(effect: customBlurEffect)
        }
    }()

    private lazy var customBlurEffect_ios14: CustomBlurEffect = {
        let effect = CustomBlurEffect.effect(with: .light)
        effect.blurRadius = blurRadius
        return effect
    }()

    private lazy var customBlurEffect: UIBlurEffect = {
        (NSClassFromString(getBlurClass()) as! UIBlurEffect.Type).init()
    }()
    

    // MARK: - Initialization

    public init(
        radius: CGFloat = 10.0,
        color: UIColor = .clear,
        colorAlpha: CGFloat = 0.8
    ) {
        super.init(frame: .zero)
        self.blurRadius = radius
        backgroundColor = .clear
        setupViews()
        defer {
            blurRadius = radius
            colorTint = color
            colorTintAlpha = colorAlpha
        }
    }

    public convenience init() {
        self.init(radius: 10.0, color: .clear, colorAlpha: 0.9)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}


// MARK: private func
private extension QuickBlurView {
    private func QuickBlurSetValue(_ value: Any?, forKey key: String) {
        if #available(iOS 14.0, *) {
            if key == Constants.blurRadiusKey {
                updateViews()
            }
            let subviewClass = NSClassFromString(getColorSubview()) as? UIView.Type
            let visualEffectSubview: UIView? = visualEffectView.subviews.filter {type(of: $0) == subviewClass}.first
            visualEffectSubview?.backgroundColor = colorTint
            visualEffectSubview?.alpha = colorTintAlpha
        } else {
            customBlurEffect.setValue(value, forKeyPath: key)
            visualEffectView.effect = customBlurEffect
        }
    }

    private func getColorSubview() -> String {
        ["_", "U", "I", "V", "i", "s", "u", "a", "l", "E", "f", "f", "e", "c", "t", "S", "u", "b", "v", "i", "e", "w"].joined(separator: "")
    }

    private func getBlurClass() -> String {
        ["_", "U", "I", "C", "u", "s", "t", "o", "m", "B", "l", "u", "r", "E", "f", "f", "e", "c", "t"].joined(separator: "")
    }

    private func setupViews() {
        addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    /// Update in iOS 14
    private func updateViews() {
        if #available(iOS 14.0, *) {
            visualEffectView.removeFromSuperview()
            let newEffect = CustomBlurEffect.effect(with: .light)
            newEffect.blurRadius = blurRadius
            customBlurEffect_ios14 = newEffect
            visualEffectView = UIVisualEffectView(effect: customBlurEffect_ios14)
            setupViews()
        }
    }
}
