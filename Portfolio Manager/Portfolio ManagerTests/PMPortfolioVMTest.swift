//
//  PMPortfolioVMTest.swift
//  Portfolio ManagerTests
//
//  Created by Pranay Jadhav on 16/11/25.
//

import XCTest
@testable import Portfolio_Manager

// MARK: - Mock Models
extension PMUserHolding {
    static func mock(symbol: String,
                     qty: Int,
                     ltp: Double,
                     avg: Double,
                     close: Double) -> PMUserHolding {
        return PMUserHolding(symbol: symbol,
                             quantity: qty,
                             ltp: ltp,
                             avgPrice: avg,
                             close: close)
    }
}

// MARK: - Mock Delegate
class MockPortfolioDelegate: PMPortfolioDelegate {
    
    var didUpdateCalled = false
    var didFailCalled = false
    var noStocksCalled = false
    var errorPassed: Error?

    func didUpdateStockData() {
        didUpdateCalled = true
    }

    func didFailureToUpdateStockData(error: Error) {
        didFailCalled = true
        errorPassed = error
    }

    func noStocksDataAvailable() {
        noStocksCalled = true
    }
    
    func shouldShowLoader() {}
    
    func shouldHideLoader() {}
}

// MARK: - Mock Network Manager
class MockNetworkManager {

    var shouldFail = false
    var mockStocks: [PMUserHolding] = []

    func fetchHoldings(completion: @escaping (Result<[PMUserHolding], Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "TEST", code: -99)))
        } else {
            completion(.success(mockStocks))
        }
    }
}

// MARK: - Mock CoreData Manager
class MockCoreDataManager {

    var storedHoldings: [MockStoredHolding] = []

    func getAllHoldings() -> [MockStoredHolding] {
        return storedHoldings
    }
}

// MARK: - StoredHolding Dummy
class MockStoredHolding {
    var symbol: String
    var quantity: Int
    var ltp: Double
    var avgPrice: Double
    var close: Double

    init(symbol: String, quantity: Int, ltp: Double, avgPrice: Double, close: Double) {
        self.symbol = symbol
        self.quantity = quantity
        self.ltp = ltp
        self.avgPrice = avgPrice
        self.close = close
    }
}

final class PMPortfolioVMTests: XCTestCase {

    var viewModel: PMPortfolioVM!
    var mockDelegate: MockPortfolioDelegate!
    var mockNetwork: MockNetworkManager!
    var mockCoreData: MockCoreDataManager!

    override func setUp() {
        super.setUp()
        viewModel = PMPortfolioVM()
        mockDelegate = MockPortfolioDelegate()
        mockNetwork = MockNetworkManager()
        mockCoreData = MockCoreDataManager()

        viewModel.delegate = mockDelegate
    }

    override func tearDown() {
        viewModel = nil
        mockDelegate = nil
        mockNetwork = nil
        mockCoreData = nil
        super.tearDown()
    }

    // MARK: - Test parseFetchedData Calculation
    func testParseFetchedDataCalculations() {
        let stocks = [
            PMUserHolding.mock(symbol: "AAPL", qty: 10, ltp: 100, avg: 80, close: 110),
            PMUserHolding.mock(symbol: "TSLA", qty: 5, ltp: 200, avg: 150, close: 180)
        ]

        viewModel.parseFetchedData(stocks: stocks)

        XCTAssertEqual(viewModel.getCurrentValue(), 100*10 + 200*5) // 2000
        XCTAssertEqual(viewModel.getInvestment(), 80*10 + 150*5) // 1550
        XCTAssertEqual(viewModel.getTotalPnL(), 2000 - 1550) // 450
        XCTAssertEqual(viewModel.getPercentageChangePnL(), (450*100)/1550)
        XCTAssertTrue(mockDelegate.didUpdateCalled)
    }

    // MARK: - Sorting Tests
    func testSortingLowToHighHighToLow() {
        let stocks = [
            PMUserHolding.mock(symbol: "A", qty: 1, ltp: 100, avg: 50, close: 90),// PnL = 50
            PMUserHolding.mock(symbol: "B", qty: 1, ltp: 200, avg: 210, close: 205) // PnL = -10
        ]

        viewModel.parseFetchedData(stocks: stocks)

        //low to high
        viewModel.sortList()
        XCTAssertEqual(viewModel.getStocks().first?.symbol, "B")

        //high to low
        viewModel.sortList()
        XCTAssertEqual(viewModel.getStocks().first?.symbol, "A")

        //revert to original
        viewModel.sortList()
        XCTAssertEqual(viewModel.getStocks().first?.symbol, "A") // original order
    }

    // MARK: - Search Filter
    func testFilterBySearch() {
        let stocks = [
            PMUserHolding.mock(symbol: "AAPL", qty: 1, ltp: 100, avg: 90, close: 95),
            PMUserHolding.mock(symbol: "TSLA", qty: 1, ltp: 200, avg: 190, close: 205)
        ]

        viewModel.parseFetchedData(stocks: stocks)

        viewModel.filterBySearch(search: "AAP")
        XCTAssertEqual(viewModel.getStocks().count, 1)

        viewModel.filterBySearch(search: "")
        XCTAssertEqual(viewModel.getStocks().count, 2)
    }

    // MARK: - checkSavedHoldings()
    func testCheckSavedHoldingsWithData() {
        mockCoreData.storedHoldings = [
            MockStoredHolding(symbol: "AAPL", quantity: 1, ltp: 100, avgPrice: 90, close: 95)
        ]

        viewModel.checkSavedHoldings()

        XCTAssertTrue(mockDelegate.didUpdateCalled)
        XCTAssertFalse(mockDelegate.noStocksCalled)
    }
}
