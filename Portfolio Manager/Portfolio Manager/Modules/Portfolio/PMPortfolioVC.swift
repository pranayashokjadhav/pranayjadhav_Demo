//
//  PMPortfolioVC.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//

import UIKit

class PMPortfolioVC: PMBaseViewController,
                     UITableViewDelegate,
                     UITableViewDataSource,
                     PMPortfolioDelegate {

    //MARK: - UI views
    private let parentTableView : UITableView = {
        let parentTableView = UITableView()
        parentTableView.backgroundColor = ThemeManager.shared.theme?.primaryWhite
        parentTableView.separatorStyle = .none
        parentTableView.translatesAutoresizingMaskIntoConstraints = false
        return parentTableView
    }()
    
    private let bottomView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = ThemeManager.shared.theme?.grayShade
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.clipsToBounds = true
        return bottomView
    }()
    
    private let profitLossLbl : UILabel = {
        let profitLossLbl = UILabel()
        profitLossLbl.createRegular16()
        return profitLossLbl
    }()
    
    private let totalPnL : UILabel = {
        let totalPnL = UILabel()
        totalPnL.createRegular16()
        return totalPnL
    }()
    
    private let chevronImg : UIImageView = {
        let chevronImg = UIImageView(image: UIImage(named: "down"))
        chevronImg.translatesAutoresizingMaskIntoConstraints = false
        chevronImg.clipsToBounds = true
        return chevronImg
    }()
    
    private let bottomViewFiller : UIView = {
        let bottomViewFiller = UIView()
        bottomViewFiller.backgroundColor = ThemeManager.shared.theme?.grayShade
        bottomViewFiller.translatesAutoresizingMaskIntoConstraints = false
        bottomViewFiller.clipsToBounds = true
        return bottomViewFiller
    }()
    
    //Bottom Sheet
    private let bottomSheetView : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = ThemeManager.shared.theme?.grayShade
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.clipsToBounds = true
        return bottomView
    }()
    
    private let currentValueText : UILabel = {
        let currentValueText = UILabel()
        currentValueText.createRegular16()
        return currentValueText
    }()
    
    private let currentValue : UILabel = {
        let currentValue = UILabel()
        currentValue.createRegular16()
        return currentValue
    }()
    
    private let totalInvestmentText : UILabel = {
        let totalInvestmentText = UILabel()
        totalInvestmentText.createRegular16()
        return totalInvestmentText
    }()
    
    private let totalInvestment : UILabel = {
        let totalInvestment = UILabel()
        totalInvestment.createRegular16()
        return totalInvestment
    }()
    
    private let todaysPnLText : UILabel = {
        let todaysPnLText = UILabel()
        todaysPnLText.createRegular16()
        return todaysPnLText
    }()
    
    private let todaysPnL : UILabel = {
        let todaysPnL = UILabel()
        todaysPnL.createRegular16()
        return todaysPnL
    }()
    
    private let bottomSheetSeperator : UIView = {
        let bottomSheetSeperator = UIView()
        bottomSheetSeperator.backgroundColor = ThemeManager.shared.theme?.lightGray
        bottomSheetSeperator.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetSeperator.clipsToBounds = true
        return bottomSheetSeperator
    }()
    
    private lazy var bottomSheetBottom = bottomSheetView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0)
    
    private var isBottomSheetExpanded: Bool = false
    private var isNoDataAvailable = false
    
    private let viewModel = PMPortfolioVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK: - UI Helpers
    func configureView() {
        view.addSubview(parentTableView)
        bottomView.addSubview(profitLossLbl)
        bottomView.addSubview(chevronImg)
        bottomView.addSubview(totalPnL)
        
        bottomSheetView.addSubview(currentValueText)
        bottomSheetView.addSubview(currentValue)
        bottomSheetView.addSubview(totalInvestmentText)
        bottomSheetView.addSubview(totalInvestment)
        bottomSheetView.addSubview(todaysPnLText)
        bottomSheetView.addSubview(todaysPnL)
        bottomSheetView.addSubview(bottomSheetSeperator)
        view.addSubview(bottomSheetView)
        
        view.addSubview(bottomView)
        view.addSubview(bottomViewFiller)
        
        setUpNavigationBarApperance()
        
        NSLayoutConstraint.activate([
    
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            parentTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            parentTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            parentTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            parentTableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            //Bottom sheet
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetBottom,
            
            currentValue.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 15),
            currentValue.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -16),
            currentValueText.topAnchor.constraint(equalTo: currentValue.topAnchor),
            currentValueText.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 16),
            
            totalInvestment.topAnchor.constraint(equalTo: currentValue.bottomAnchor, constant: 20),
            totalInvestment.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -16),
            totalInvestmentText.topAnchor.constraint(equalTo: totalInvestment.topAnchor),
            totalInvestmentText.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 16),
            
            todaysPnL.topAnchor.constraint(equalTo: totalInvestment.bottomAnchor, constant: 20),
            todaysPnL.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -16),
            todaysPnLText.topAnchor.constraint(equalTo: todaysPnL.topAnchor),
            todaysPnLText.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 16),
            todaysPnL.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor, constant: -15),
            
            bottomSheetSeperator.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor, constant: 16),
            bottomSheetSeperator.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor, constant: -16),
            bottomSheetSeperator.heightAnchor.constraint(equalToConstant: 1),
            bottomSheetSeperator.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor, constant: -1),
            
            //Bottom View
            bottomViewFiller.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -2),
            bottomViewFiller.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomViewFiller.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomViewFiller.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profitLossLbl.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            profitLossLbl.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            
            chevronImg.centerYAnchor.constraint(equalTo: profitLossLbl.centerYAnchor),
            chevronImg.leadingAnchor.constraint(equalTo: profitLossLbl.trailingAnchor, constant: 10),
            chevronImg.heightAnchor.constraint(equalToConstant: 12),
            chevronImg.widthAnchor.constraint(equalToConstant: 12),
            
            totalPnL.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            totalPnL.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            totalPnL.leadingAnchor.constraint(greaterThanOrEqualTo: chevronImg.trailingAnchor, constant: 10),
            totalPnL.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10)
            
        ])
        
        parentTableView.register(PMPortfolioCells.self,
                                  forCellReuseIdentifier: PMPortfolioCells.identifier)
        parentTableView.register(PMNoDataCell.self,
                                  forCellReuseIdentifier: PMNoDataCell.identifier)
        
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomSheetView.layer.cornerRadius = 6
        bottomSheetView.layer.borderWidth = 1
        bottomSheetView.layer.borderColor = ThemeManager.shared.theme?.lightGrayBorder.cgColor
       
        profitLossLbl.createStarText(text: PMConstants.profitLoss)
        currentValueText.createStarText(text: PMConstants.currentValue)
        totalInvestmentText.createStarText(text: PMConstants.totalInvestment)
        todaysPnLText.createStarText(text: PMConstants.todaysPnL)
        
        profitLossLbl.isUserInteractionEnabled = true
        chevronImg.isUserInteractionEnabled = true
        
        let bottomSheetLblTapEvent = UITapGestureRecognizer(target: self, action: #selector(bottomSheetTapAction))
        profitLossLbl.addGestureRecognizer(bottomSheetLblTapEvent)
        let bottomSheetImgTapEvent = UITapGestureRecognizer(target: self, action: #selector(bottomSheetTapAction))
        chevronImg.addGestureRecognizer(bottomSheetImgTapEvent)
        
        totalPnL.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        parentTableView.delegate = self
        parentTableView.dataSource = self
        parentTableView.estimatedRowHeight = 100
        
        isSheetExpanded(isBottomSheetExpanded, isInitialLoad: true)
        
        viewModel.delegate = self
        viewModel.fetchStocks()
    }
    
    func isSheetExpanded(_ expanded: Bool, isInitialLoad: Bool = false) {
        chevronImg.rotated180()
        if expanded {
            bottomView.layer.cornerRadius = 0
            bottomView.layer.borderWidth = 0
            bottomSheetBottom.constant = 1
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            }
        } else {
            bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            bottomView.layer.cornerRadius = 6
            bottomView.layer.borderWidth = 1
            bottomView.layer.borderColor = ThemeManager.shared.theme?.lightGrayBorder.cgColor
            bottomSheetBottom.constant = 500
            
            //To avoid refreshing tableview until its not loaded
            if !isInitialLoad {
                UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func enableUIElements(_ status: Bool) {
        self.isNoDataAvailable = !status
        self.bottomView.isHidden = !status
        self.bottomViewFiller.isHidden = !status
        self.enableSort(status)
        self.enableSearch(status)
    }
    
    //MARK: - Actions
    @objc func bottomSheetTapAction() {
        isBottomSheetExpanded.toggle()
        isSheetExpanded(isBottomSheetExpanded)
    }
    
    override func sortTapAction() {
        self.viewModel.sortList()
        DispatchQueue.main.async { [weak self] in
            let sortMsg = self?.viewModel.sortMsg() ?? ""
            self?.showSnackbar(message: sortMsg)
            self?.parentTableView.reloadData()
        }
    }
    
    override func didCancelSearch() {
        self.filterData(text: "")
    }
    
    //MARK: - Tableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isNoDataAvailable {
            return 1
            
        } else if viewModel.getCopyOfStocks().count > 0 && viewModel.getStocks().count == 0 {
            return 1
            
        } else {
            return viewModel.getStocks().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.isNoDataAvailable {
            
            guard let noDataCell = tableView.dequeueReusableCell(withIdentifier: PMNoDataCell.identifier,for: indexPath) as? PMNoDataCell else { return UITableViewCell() }
            
            noDataCell.configureCell(searchText: PMConstants.noDataAvailable)
            
            return noDataCell
            
        } else if viewModel.getCopyOfStocks().count > 0 && viewModel.getStocks().count == 0 {
            
            guard let noDataCell = tableView.dequeueReusableCell(withIdentifier: PMNoDataCell.identifier,for: indexPath) as? PMNoDataCell else { return UITableViewCell() }
            
            noDataCell.configureCell(searchText: viewModel.getSearch())
            
            return noDataCell
            
        } else {
            
            guard let positionCell = tableView.dequeueReusableCell(withIdentifier: PMPortfolioCells.identifier,for: indexPath) as? PMPortfolioCells else { return UITableViewCell() }
            
            let data = viewModel.getStocks()[indexPath.row]
            positionCell.configureCell(data: data)
            
            return positionCell
        }
    }
    
    //MARK: - Viewmodel delegates
    func shouldShowLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.showLoading()
        }
    }
    
    func shouldHideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
        }
    }
    
    func didUpdateStockData() {
        DispatchQueue.main.async { [weak self] in
            self?.enableUIElements(true)
            //Clears all previous data
            PMCoreDataManager.shared.deleteAllData()
            //Adds new data
            PMCoreDataManager.shared.addHolding(data: self?.viewModel.getStocks() ?? [])
            
            self?.parentTableView.reloadData()
            self?.currentValue.currencyFormatter(value: self?.viewModel.getCurrentValue() ?? 0)
            self?.totalInvestment.currencyFormatter(value: self?.viewModel.getInvestment() ?? 0)
            self?.todaysPnL.currencyFormatter(value: self?.viewModel.getTodayPnL() ?? 0, shouldCheckPnL: true)
            self?.totalPnL.currencyFormatter(value: self?.viewModel.getTotalPnL() ?? 0,
                                             percentageValue: self?.viewModel.getPercentageChangePnL() ?? 0,
                                             shouldCheckPnL: true)
        }
    }
    
    func didFailureToUpdateStockData(error: any Error) {
        //Handle error here
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.checkSavedHoldings()
        }
    }
    
    func noStocksDataAvailable() {
        DispatchQueue.main.async { [weak self] in
            self?.enableUIElements(false)
            self?.parentTableView.reloadData()
        }
    }
    
    override func textFieldDidChangeSelection(_ textField: UITextField) {
        self.filterData(text: textField.text ?? "")
    }
    
    func filterData(text: String) {
        self.viewModel.filterBySearch(search: text)
        DispatchQueue.main.async { [weak self] in
            self?.parentTableView.reloadData()
        }
    }
}

