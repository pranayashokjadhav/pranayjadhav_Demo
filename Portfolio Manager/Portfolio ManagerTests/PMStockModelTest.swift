//
//  PMStockModelTest.swift
//  Portfolio ManagerTests
//
//  Created by Pranay Jadhav on 16/11/25.
//

import XCTest
@testable import Portfolio_Manager

final class PMHoldingsResponseTests: XCTestCase {

    // MARK: - Test JSON Decoding (Correct JSON)
    func testDecodingSuccess() throws {
        let json = """
        {
            "data": {
                "userHolding": [
                    {
                        "symbol": "AAPL",
                        "quantity": 10,
                        "ltp": 150.5,
                        "avgPrice": 100.0,
                        "close": 152.0
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PMHoldingsResponse.self, from: json)

        XCTAssertNotNil(decoded.data)
        XCTAssertEqual(decoded.data?.userHolding?.count, 1)

        let holding = decoded.data?.userHolding?.first
        XCTAssertEqual(holding?.symbol, "AAPL")
        XCTAssertEqual(holding?.quantity, 10)
        XCTAssertEqual(holding?.ltp, 150.5)
        XCTAssertEqual(holding?.avgPrice, 100.0)
        XCTAssertEqual(holding?.close, 152.0)
    }

    // MARK: - Test Decoding With Missing Fields
    func testDecodingMissingFields() throws {
        let json = """
        {
            "data": {
                "userHolding": [
                    {
                        "symbol": "TSLA"
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PMHoldingsResponse.self, from: json)
        let holding = decoded.data?.userHolding?.first

        XCTAssertEqual(holding?.symbol, "TSLA")
        XCTAssertNil(holding?.quantity)
        XCTAssertNil(holding?.ltp)
        XCTAssertNil(holding?.avgPrice)
        XCTAssertNil(holding?.close)
    }

    // MARK: - Test Value Helpers (currentValue, investment, pnlValue)
    func testValueCalculations() {
        let holding = PMUserHolding(symbol: "AAPL",
                                    quantity: 10,
                                    ltp: 150,
                                    avgPrice: 100,
                                    close: 148)

        XCTAssertEqual(holding.currentValue(), 150 * 10)
        XCTAssertEqual(holding.investment(), 100 * 10)
        XCTAssertEqual(holding.pnlValue(), (150 * 10) - (100 * 10))  // 500
    }

    // MARK: - Test PNL Currency Formatting
    func testPNLFormatted() {
        let holding = PMUserHolding(symbol: "AAPL",
                                    quantity: 5,
                                    ltp: 120,
                                    avgPrice: 100,
                                    close: 110)

        // pnl = (120 * 5) - (100 * 5) = 100
        let pnlString = holding.pnl()
        XCTAssertEqual(pnlString, "₹100.00")
    }

    // MARK: - Test getLtp Formatting
    func testGetLtpFormatting() {
        let holding = PMUserHolding(symbol: "AAPL",
                                    quantity: 1,
                                    ltp: 250.75,
                                    avgPrice: 0,
                                    close: 0)

        XCTAssertEqual(holding.getLtp(), "₹250.75")
    }

    // MARK: - Test Currency Formatter With Negative Values
    func testCurrencyFormatterNegative() {
        let holding = PMUserHolding(symbol: "AAPL",
                                    quantity: 1,
                                    ltp: 90,
                                    avgPrice: 100,
                                    close: 95)

        // pnl = 90 - 100 = -10
        XCTAssertEqual(holding.pnl(), "-₹10.00")
    }

    // MARK: - Test JSON Null Handling
    func testDecodingNullValues() throws {
        let json = """
        {
            "data": {
                "userHolding": [
                    {
                        "symbol": null,
                        "quantity": null,
                        "ltp": null,
                        "avgPrice": null,
                        "close": null
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(PMHoldingsResponse.self, from: json)
        let holding = decoded.data?.userHolding?.first

        XCTAssertNil(holding?.symbol)
        XCTAssertNil(holding?.quantity)
        XCTAssertNil(holding?.ltp)
        XCTAssertNil(holding?.avgPrice)
        XCTAssertNil(holding?.close)

        XCTAssertEqual(holding?.currentValue(), 0)
        XCTAssertEqual(holding?.investment(), 0)
        XCTAssertEqual(holding?.pnlValue(), 0)
        XCTAssertEqual(holding?.pnl(), "₹0.00")
    }
}
