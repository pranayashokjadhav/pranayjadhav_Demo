//
//  PMNoDataCell.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 16/11/25.
//
import UIKit

class PMNoDataCell: UITableViewCell {
    static let identifier = "PMNoDataCell"
    
    private let noData: UILabel = {
        let holdingName = UILabel()
        holdingName.textAlignment = .center
        holdingName.translatesAutoresizingMaskIntoConstraints = false
        holdingName.textColor = ThemeManager.shared.theme?.blackText
        holdingName.font = UIFont.regularFont_16()
        holdingName.numberOfLines = 0
        return holdingName
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(noData)
        
        NSLayoutConstraint.activate([
            noData.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            noData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            noData.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            noData.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            
        ])
    }
    
    func configureCell(searchText: String) {
        if searchText == PMConstants.noDataAvailable {
            self.noData.text = searchText
        } else {
            self.noData.text = "No data found for '\(searchText)'. Please try again"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

