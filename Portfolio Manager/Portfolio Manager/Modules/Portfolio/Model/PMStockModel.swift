//
//  PMStockModel.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import Foundation

nonisolated
struct PMHoldingsResponse: Decodable {
    let data: PMHoldingsData?
}

struct PMHoldingsData: Decodable {
    let userHolding: [PMUserHolding]?
}

struct PMUserHolding: Decodable {
    let symbol: String?
    let quantity: Int?
    let ltp: Double?
    let avgPrice: Double?
    let close: Double?
    
    func currentValue() -> Double {
        return (ltp ?? 0) * Double(quantity ?? 0)
    }
    
    func investment() -> Double {
        return (avgPrice ?? 0) * Double(quantity ?? 0)
    }
    
    func pnlValue() -> Double {
        return currentValue() - investment()
    }
    
    func pnl() -> String {
        let value = currentValue() - investment()
        return currencyFormatter(value: value)
    }
    
    func getLtp() -> String {
        return currencyFormatter(value: (ltp ?? 0))
    }
    
    func currencyFormatter(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₹"
        formatter.locale = Locale(identifier: "en_IN")
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "Rs 0"
    }
}

