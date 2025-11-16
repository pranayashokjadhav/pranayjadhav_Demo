//
//  PMTheme.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//

//Theme manager class 
import UIKit

protocol PMTheme {
    var primaryWhite: UIColor { get }
    var primaryWhiteAlpha1: UIColor { get }
    var secondaryBlue: UIColor { get }
    var lightGray: UIColor { get }
    var lightGrayBorder: UIColor { get }
    var grayShade: UIColor { get }
    var redText: UIColor { get }
    var greenText: UIColor { get }
    var blackText: UIColor { get }
    var grayText: UIColor { get }
}

struct PMAppTheme: PMTheme {
    var primaryWhite: UIColor { return UIColor(hexStr: "#ffffff")! }
    var primaryWhiteAlpha1: UIColor { return UIColor.white.withAlphaComponent(0.1) }
    var secondaryBlue: UIColor { return UIColor(hexStr: "#033364")! }
    var grayShade: UIColor { return UIColor(hexStr: "#E5E5E5")! }
    var lightGray: UIColor { return UIColor.lightGray }
    var lightGrayBorder: UIColor { return UIColor.lightGray.withAlphaComponent(0.4) }
    var redText: UIColor { return UIColor(hexStr: "#f15c66")! }
    var greenText: UIColor { return UIColor(hexStr: "#1bb37d")! }
    var blackText: UIColor { return UIColor(hexStr: "#484848")! }
    var grayText: UIColor { return UIColor(hexStr: "#8B99A7")! }
    
}

class ThemeManager {
    private init() {}
    var theme: PMTheme?
    static let shared = ThemeManager()
    
    func setTheme(theme: PMTheme) {
        self.theme = theme
    }
}
