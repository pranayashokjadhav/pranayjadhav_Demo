//
//  PMBaseViewController.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//

import UIKit

class PMBaseViewController: UIViewController, UITextFieldDelegate {

    //MARK: - Navigation bar views
    private let statusBar : UIView = {
        let navBar = UIView()
        navBar.backgroundColor = ThemeManager.shared.theme?.secondaryBlue
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.clipsToBounds = true
        return navBar
    }()
    
    private let navBar : UIView = {
        let navBar = UIView()
        navBar.backgroundColor = ThemeManager.shared.theme?.secondaryBlue
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.clipsToBounds = true
        return navBar
    }()
    
    private let profileImage : UIImageView = {
        let profileImage = UIImageView(image: UIImage(named: "user"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    private let headerLbl : UILabel = {
        let headerLbl = UILabel()
        headerLbl.text = PMConstants.portFolio
        headerLbl.font = UIFont.mediumFont()
        headerLbl.textColor = ThemeManager.shared.theme?.primaryWhite
        headerLbl.translatesAutoresizingMaskIntoConstraints = false
        return headerLbl
    }()
    
    private let sortImage : UIImageView = {
        let profileImage = UIImageView(image: UIImage(named: "sort"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    private let verticalView : UIView = {
        let navBar = UIView()
        navBar.backgroundColor = ThemeManager.shared.theme?.primaryWhiteAlpha1
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.clipsToBounds = true
        return navBar
    }()
    
    private let searchImage : UIImageView = {
        let profileImage = UIImageView(image: UIImage(named: "search"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    private let searchBarBgView : UIView = {
        let searchBarBgView = UIView()
        searchBarBgView.translatesAutoresizingMaskIntoConstraints = false
        searchBarBgView.backgroundColor = .white
        searchBarBgView.clipsToBounds = true
        return searchBarBgView
    }()
    
    private let searchBar : UITextField = {
        let searchBar = UITextField()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = PMConstants.search
        searchBar.backgroundColor = .white
        searchBar.clipsToBounds = true
        return searchBar
    }()
    
    private let searchCancel : UIImageView = {
        let searchCancel = UIImageView(image: UIImage(systemName: "x.circle.fill"))
        searchCancel.translatesAutoresizingMaskIntoConstraints = false
        searchCancel.clipsToBounds = true
        searchCancel.tintColor = ThemeManager.shared.theme?.secondaryBlue
        searchCancel.contentMode = .scaleAspectFill
        return searchCancel
    }()
    
    let imageSizes: CGFloat = 20
    private var isShowingLoading = false
    
    //MARK: - UI Helpers
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpNavigationBarApperance() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.barStyle = .black
        view.addSubview(statusBar)
        view.addSubview(navBar)
        view.addSubview(profileImage)
        view.addSubview(headerLbl)
        view.addSubview(searchImage)
        view.addSubview(verticalView)
        view.addSubview(sortImage)
        view.addSubview(searchBarBgView)
        searchBarBgView.addSubview(searchBar)
        searchBarBgView.addSubview(searchCancel)
        
        NSLayoutConstraint.activate([
            
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44),
            
            profileImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: imageSizes),
            profileImage.widthAnchor.constraint(equalToConstant: imageSizes),
            
            headerLbl.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            headerLbl.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 14),
            
            searchImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchImage.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -16),
            searchImage.heightAnchor.constraint(equalToConstant: imageSizes),
            searchImage.widthAnchor.constraint(equalToConstant: imageSizes),
            
            verticalView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            verticalView.trailingAnchor.constraint(equalTo: searchImage.leadingAnchor, constant: -16),
            verticalView.heightAnchor.constraint(equalToConstant: imageSizes),
            verticalView.widthAnchor.constraint(equalToConstant: 1),
            
            sortImage.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            sortImage.trailingAnchor.constraint(equalTo: verticalView.leadingAnchor, constant: -16),
            sortImage.heightAnchor.constraint(equalToConstant: imageSizes),
            sortImage.widthAnchor.constraint(equalToConstant: imageSizes),
            
            searchBarBgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarBgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarBgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarBgView.heightAnchor.constraint(equalToConstant: 44),
            
            searchBar.centerYAnchor.constraint(equalTo: searchBarBgView.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchBarBgView.trailingAnchor, constant: -48),
            searchBar.leadingAnchor.constraint(equalTo: searchBarBgView.leadingAnchor, constant: 16),
            searchBar.heightAnchor.constraint(equalToConstant: 44),
            
            searchCancel.centerYAnchor.constraint(equalTo: searchBarBgView.centerYAnchor),
            searchCancel.trailingAnchor.constraint(equalTo: searchBarBgView.trailingAnchor, constant: -16),
            searchCancel.heightAnchor.constraint(equalToConstant: imageSizes),
            searchCancel.widthAnchor.constraint(equalToConstant: imageSizes)
            
        ])
        
        searchBarBgView.isHidden = true
        searchBar.delegate = self
        sortImage.isUserInteractionEnabled = true
        let sortTapEvent = UITapGestureRecognizer(target: self, action: #selector(sortTapAction))
        sortImage.addGestureRecognizer(sortTapEvent)
        
        searchImage.isUserInteractionEnabled = true
        let searchImageTapEvent = UITapGestureRecognizer(target: self, action: #selector(searchTapAction))
        searchImage.addGestureRecognizer(searchImageTapEvent)
        
        searchCancel.isUserInteractionEnabled = true
        let searchCancelTapEvent = UITapGestureRecognizer(target: self, action: #selector(searchCancelTapAction))
        searchCancel.addGestureRecognizer(searchCancelTapEvent)
    }
    
    func enableSort(_ status: Bool) {
        self.sortImage.isHidden = !status
    }
    
    func enableSearch(_ status: Bool) {
        self.searchImage.isHidden = !status
    }
    
    //MARK: - Actions
    @objc func sortTapAction() {}
    
    @objc func searchTapAction() {
        searchBarBgView.isHidden = false
        self.searchBar.text = ""
        self.searchBar.becomeFirstResponder()
    }
    
    @objc func searchCancelTapAction() {
        self.searchBarBgView.isHidden = true
        self.view.endEditing(true)
        self.didCancelSearch()
    }
    
    func didCancelSearch() {}
    
    func textFieldDidChangeSelection(_ textField: UITextField) {}
    
    //MARK: - Loaders
    func showLoading() {
        if isShowingLoading == true {
            return
        }
        isShowingLoading = true
        DispatchQueue.main.async { [weak self] in
            let parentView = self?.view
            guard let parent = parentView else { return }

            let container = UIView(frame: parent.bounds)
            container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            container.tag = 10001
            let activity = UIActivityIndicatorView(style: .large)
            activity.color = ThemeManager.shared.theme?.secondaryBlue
            activity.startAnimating()
            activity.translatesAutoresizingMaskIntoConstraints = false

            container.addSubview(activity)
            NSLayoutConstraint.activate([
                activity.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                activity.centerYAnchor.constraint(equalTo: container.centerYAnchor)
            ])
            self?.view.addSubview(container)
        }
    }
    
    func hideLoading() {
        isShowingLoading = false
        DispatchQueue.main.async { [weak self] in
            if let blurView = self?.view.viewWithTag(10001) {
                UIView.animate(withDuration: TimeInterval(0.3), delay: 0.0, options: [.curveEaseOut], animations: { () -> Void in 
                    blurView.alpha = 0.0
                    blurView.removeFromSuperview()
                })
            }
        }
    }
}
