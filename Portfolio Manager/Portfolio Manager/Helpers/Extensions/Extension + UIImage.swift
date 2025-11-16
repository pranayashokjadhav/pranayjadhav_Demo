//
//  Extension + UIImage.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import UIKit

extension UIImageView {
    
    func rotated180() {
        UIView.animate(withDuration: 0.1) {
            self.transform = self.transform.rotated(by: .pi)
        }
    }
}
