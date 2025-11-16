//
//  PMPortfolioCells.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import UIKit

class PMPortfolioCells: UITableViewCell {
    static let identifier = "PMPortfolioCells"
    
    //MARK: - UI components
    private let holdingName: UILabel = {
        let holdingName = UILabel()
        holdingName.textAlignment = .left
        holdingName.translatesAutoresizingMaskIntoConstraints = false
        holdingName.textColor = ThemeManager.shared.theme?.blackText
        holdingName.font = UIFont.mediumFont()
        holdingName.numberOfLines = 0
        return holdingName
        
    }()
    
    private let holdingLTP: UILabel = {
        let holdingLTP = UILabel()
        holdingLTP.translatesAutoresizingMaskIntoConstraints = false
        holdingLTP.textAlignment = .right
        holdingLTP.numberOfLines = 0
        return holdingLTP
        
    }()
    
    private let holdingQuantity: UILabel = {
        let holdingQuantity = UILabel()
        holdingQuantity.translatesAutoresizingMaskIntoConstraints = false
        holdingQuantity.textAlignment = .left
        holdingQuantity.numberOfLines = 0
        return holdingQuantity
        
    }()
    
    private let holdingPnL: UILabel = {
        let holdingPnL = UILabel()
        holdingPnL.translatesAutoresizingMaskIntoConstraints = false
        holdingPnL.textAlignment = .right
        holdingPnL.numberOfLines = 0
        return holdingPnL
        
    }()
    
    private let bottomSeperator: UIView = {
        let bottomSeperator = UIView()
        bottomSeperator.translatesAutoresizingMaskIntoConstraints = false
        bottomSeperator.backgroundColor = ThemeManager.shared.theme?.grayShade
        return bottomSeperator
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(holdingName)
        contentView.addSubview(holdingLTP)
        contentView.addSubview(holdingQuantity)
        contentView.addSubview(holdingPnL)
        contentView.addSubview(bottomSeperator)
        
        NSLayoutConstraint.activate([
            holdingName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            holdingName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            holdingName.trailingAnchor.constraint(equalTo: holdingLTP.leadingAnchor, constant: -10),
            holdingName.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            holdingLTP.topAnchor.constraint(equalTo: holdingName.topAnchor),
            holdingLTP.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            holdingQuantity.topAnchor.constraint(equalTo: holdingName.bottomAnchor, constant: 25),
            holdingQuantity.leadingAnchor.constraint(equalTo: holdingName.leadingAnchor),
            holdingQuantity.trailingAnchor.constraint(equalTo: holdingPnL.leadingAnchor, constant: -10),
            holdingQuantity.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            holdingPnL.topAnchor.constraint(equalTo: holdingLTP.bottomAnchor, constant: 25),
            holdingPnL.trailingAnchor.constraint(equalTo: holdingLTP.trailingAnchor),
            
            bottomSeperator.topAnchor.constraint(equalTo: holdingPnL.bottomAnchor, constant: 20),
            bottomSeperator.topAnchor.constraint(equalTo: holdingQuantity.bottomAnchor, constant: 20),
            bottomSeperator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSeperator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSeperator.heightAnchor.constraint(equalToConstant: 1),
            bottomSeperator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
            
        ])
        selectionStyle = .none
    }
    
    func configureCell(data: PMUserHolding) {
        let qty = String(data.quantity ?? 0)
        
        holdingName.text = data.symbol ?? ""
        holdingLTP.createHoldingText(text: PMConstants.ltp, value: data.getLtp())
        holdingQuantity.createHoldingText(text: PMConstants.netQuantity, value: qty)
        holdingPnL.createHoldingText(text: PMConstants.pnl, value: data.pnl(), isPnL: true)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
