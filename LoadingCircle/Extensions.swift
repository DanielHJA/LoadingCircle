//
//  Extensions.swift
//  LoadingCircle
//
//  Created by Daniel Hjärtström on 2018-11-02.
//  Copyright © 2018 Sog. All rights reserved.
//

import UIKit

extension NSObject {
    func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}

extension CAShapeLayer {
    struct AnimationKeys {
        static let pulse = "pulse"
        static let opacity = "opacity"
        static let completion = "completion"
    }
}
