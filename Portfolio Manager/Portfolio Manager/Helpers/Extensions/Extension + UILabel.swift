//
//  Extension + UILabel.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import UIKit

extension UILabel {
    
    //add star to text
    func createStarText(text: String) {
        let fulltext = NSMutableAttributedString()
        fulltext.append(createColorText(text: text,
                                        color: ThemeManager.shared.theme?.blackText ?? .red,
                                        font: .regularFont_16()))
        
        fulltext.append(createColorText(text: "*",
                                        color: ThemeManager.shared.theme?.blackText ?? .red,
                                        font: .regularFont_16()))
        self.attributedText = fulltext
    }
    
    //Add multiple attributes to holding cells
    func createHoldingText(text: String, value: String, isPnL: Bool = false) {
        let fulltext = NSMutableAttributedString()
        fulltext.append(createColorText(text: text,
                                        color: ThemeManager.shared.theme?.grayText ?? .gray,
                                        font: .lightFont()))
        
        if isPnL {
            if value.contains("-") {
                fulltext.append(createColorText(text: value,
                                                color: ThemeManager.shared.theme?.redText ?? .red,
                                                font: .regularFont_16()))
                self.attributedText = fulltext
            } else {
                fulltext.append(createColorText(text: value,
                                                color: ThemeManager.shared.theme?.greenText ?? .green,
                                                font: .regularFont_16()))
                self.attributedText = fulltext
            }
        } else {
            
            fulltext.append(createColorText(text: value,
                                            color: ThemeManager.shared.theme?.blackText ?? .black,
                                            font: .regularFont_16()))
            self.attributedText = fulltext
        }
    }
    
    //Reusable text for text, color, fonts
    func createColorText(text: String, color: UIColor, font: UIFont) -> NSAttributedString {
        let attributeText = NSAttributedString(
            string: text,
            attributes: [.font: font,
                         .foregroundColor: color]
        )
        return attributeText
    }
    
    //Create reusable labels
    func createRegular16()  {
        self.font = UIFont.regularFont_16()
        self.textColor = ThemeManager.shared.theme?.blackText
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .right
        self.numberOfLines = 0
    }
    
    
    func currencyFormatter(value: Double, percentageValue: Double = 0, shouldCheckPnL: Bool = false) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₹"
        formatter.locale = Locale(identifier: "en_IN")
        formatter.maximumFractionDigits = 2              
        
        let percentage = String(format: "(%.2f%%)", percentageValue)
        let fulltext = NSMutableAttributedString()
        var text = formatter.string(from: NSNumber(value: value)) ?? "Rs 0"
        if percentageValue != 0 {
            text = text + " \(percentage)"
        }
        //Set color to texts
        if shouldCheckPnL {
            if value < 0 {
                fulltext.append(createColorText(text: text,
                                                color: ThemeManager.shared.theme?.redText ?? .red,
                                                font: .regularFont_16()))
                self.attributedText = fulltext
            } else {
                fulltext.append(createColorText(text: text,
                                                color: ThemeManager.shared.theme?.greenText ?? .red,
                                                font: .regularFont_16()))
                self.attributedText = fulltext
            }
        } else {
            self.text = text
        }
    }
}
