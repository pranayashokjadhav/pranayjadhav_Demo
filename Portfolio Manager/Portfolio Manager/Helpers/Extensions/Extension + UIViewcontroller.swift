//
//  Extension + UIViewcontroller.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 16/11/25.
//
import UIKit

extension UIViewController {
    
    func showSnackbar(message: String,
                      duration: Double = 2.0) {
        
        // Create padded label (no extra class)
        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.font = UIFont.regularFont_16()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.cornerRadius = 14
        label.clipsToBounds = true
        
        // Padding values
        let paddingH: CGFloat = 12
        let paddingV: CGFloat = 8
        
        // Max width (80% of screen)
        let maxWidth = view.frame.width * 0.8
        
        // Measure text
        let textSize = label.sizeThatFits(
            CGSize(width: maxWidth - (paddingH * 2),
                   height: CGFloat.greatestFiniteMagnitude)
        )
        
        // Set frame with padding
        let snackbarWidth = textSize.width + (paddingH * 2)
        let snackbarHeight = textSize.height + (paddingV * 2)
        
        label.frame = CGRect(
            x: (view.frame.width - snackbarWidth) / 2,
            y: view.frame.height,
            width: snackbarWidth,
            height: snackbarHeight
        )
        
        view.addSubview(label)
        
        // Animate up
        UIView.animate(withDuration: 0.25) {
            label.frame.origin.y = self.view.frame.height - snackbarHeight - 40
        }
        
        // Fade + slide down
        UIView.animate(withDuration: 0.25,
                       delay: duration,
                       options: .curveEaseOut,
                       animations: {
            label.alpha = 0
            label.frame.origin.y += 20
        }) { _ in
            label.removeFromSuperview()
        }
    }
}

