//
//  PMPortfolioVM.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import Foundation

protocol PMPortfolioDelegate: AnyObject {
    func shouldShowLoader()
    func shouldHideLoader()
    func didUpdateStockData()
    func didFailureToUpdateStockData(error: Error)
    func noStocksDataAvailable()
}

enum PMSortHelper: String {
    case lowToHigh = "Showing P&L low to high"
    case highToLow = "Showing P&L high to low"
    case normal = "Showing original"
}

class PMPortfolioVM {
    
    weak var delegate: PMPortfolioDelegate?
    private var copyOfstocks = [PMUserHolding]()
    private var stocks = [PMUserHolding]()
    private var sortHelper: PMSortHelper = .normal
    
    private var totalCurrentValue: Double? = 0
    private var totalInv: Double? = 0
    private var todayPnL: Double? = 0
    private var totalPnL: Double? = 0
    private var percChangeInPnL: Double? = 0
    
    private var searchText = ""
    
    init() {}
    
    //MARK: - API Helper & parser
    func fetchStocks() {
        self.delegate?.shouldShowLoader()
        PMNetworkManager.shared.fetchHoldings { [weak self] result in
            switch result {
            case .success(let stocks):
                self?.delegate?.shouldHideLoader()
                self?.parseFetchedData(stocks: stocks)
                
            case .failure(let error):
                self?.delegate?.shouldHideLoader()
                self?.delegate?.didFailureToUpdateStockData(error: error)
            }
        }
    }
    
    func parseFetchedData(stocks: [PMUserHolding]) {
        self.stocks = stocks
        self.copyOfstocks = stocks
        
        stocks.forEach { stock in
            
            let ltp = stock.ltp ?? 0
            let avgPrice = stock.avgPrice ?? 0
            let qty = Double(stock.quantity ?? 0)
            let close = stock.close ?? 0
            
            self.totalCurrentValue = (self.totalCurrentValue ?? 0) + (ltp * qty)
            self.totalInv = (self.totalInv ?? 0) + (avgPrice * qty)
            self.todayPnL = (self.todayPnL ?? 0) + ((close - ltp) * qty)
        }
        self.totalPnL = (self.totalCurrentValue ?? 0) - (self.totalInv ?? 0)
        self.percChangeInPnL = ((self.totalPnL ?? 0) * 100) / (self.totalInv ?? 0)
        self.delegate?.didUpdateStockData()
    }
    
    func checkSavedHoldings() {
        let previousData = PMCoreDataManager.shared.getAllHoldings()
        if previousData.count > 0 {
            var convertedData: [PMUserHolding] = []
            previousData.forEach { stock in
                convertedData.append(PMUserHolding(symbol: stock.symbol,
                                                   quantity: Int(stock.quantity),
                                                   ltp: stock.ltp,
                                                   avgPrice: stock.avgPrice,
                                                   close: stock.close))
            }
            self.parseFetchedData(stocks: convertedData)
        } else {
            self.delegate?.noStocksDataAvailable()
        }
    }
    
    //MARK: - Data Helpers
    func getCurrentValue() -> Double {
        return (totalCurrentValue ?? 0)
    }
    
    func getInvestment() -> Double {
        return (totalInv ?? 0)
    }
    
    func getTodayPnL() -> Double {
        return (todayPnL ?? 0)
    }
    
    func getTotalPnL() -> Double {
        return (totalPnL ?? 0)
    }
    
    func getPercentageChangePnL() -> Double {
        return (percChangeInPnL ?? 0)
    }
    
    func getStocks() -> [PMUserHolding] {
        return stocks
    }
    
    func getCopyOfStocks() -> [PMUserHolding] {
        return copyOfstocks
    }
    
    func getSearch() -> String {
        return searchText
    }
    
    func sortMsg() -> String {
        return sortHelper.rawValue
    }
    
    
    //MARK: - Sort / Filter helper
    func sortList() {
        if sortHelper == .normal {
            //Sort low to high
            sortHelper = .lowToHigh
            self.stocks = self.stocks.sorted{ $0.pnlValue() < $1.pnlValue() }
            
        } else if sortHelper == .lowToHigh {
            //Sort high to low
            sortHelper = .highToLow
            self.stocks = self.stocks.sorted{ $0.pnlValue() > $1.pnlValue() }
            
        } else if sortHelper == .highToLow {
            //Revert all sorting
            sortHelper = .normal
            self.stocks = self.copyOfstocks
            
        }
    }
    
    func filterBySearch(search: String) {
        searchText = search
        if search.trimmingCharacters(in: .whitespaces) == "" {
            self.stocks = self.copyOfstocks
        } else {
            self.stocks = self.copyOfstocks.filter({ $0.symbol?.contains(search) ?? false })
        }
    }
}
