//
//  RoundCorners.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 12/04/23.
//

import UIKit

extension UIView {
    /// function untuk mengatur corner agar jadi melengkung menggunakan UIBezierPath
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
