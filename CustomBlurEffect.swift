//
//  CustomBlurEffect.swift
//  QuickBlurView
//
//  Created by Krox on 2020/10/25.
//

import Foundation
public class CustomBlurEffect: UIBlurEffect {
    public var blurRadius: CGFloat = 10.0

    private enum Constants {
        static let blurRadiusKey = "blurRadius"
    }

    class func effect(with style: UIBlurEffect.Style) -> CustomBlurEffect {
        let result = super.init(style: style)
        object_setClass(result, self)
        return result as! CustomBlurEffect
    }

    public override func copy(with zone: NSZone? = nil) -> Any {
        let result = super.copy(with: zone)
        object_setClass(result, Self.self)
        return result
    }

    override var effectSettings: AnyObject {
        get {
            let settings = super.effectSettings
            settings.setValue(blurRadius, forKey: Constants.blurRadiusKey)
            return settings
        }
        set {
            super.effectSettings = newValue
        }
    }
}
