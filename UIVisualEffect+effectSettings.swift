//
//  UIVisualEffect+effectSettings.swiftß
//
//  Created by Krox on 2020/10/25.
//

import Foundation

private var AssociatedObjectHandle: UInt8 = 0

extension UIVisualEffect {
    @objc var effectSettings: AnyObject {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as AnyObject
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
