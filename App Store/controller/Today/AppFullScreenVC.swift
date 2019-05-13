//
//  AppFullScreenVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppFullScreenVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    var item:TodayItem?
    
    var handleCloseClosure:(() ->())?
    lazy var closeButton:UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "close_button").withRenderingMode(.alwaysOriginal), for: .normal)
        bt.addTarget(self, action: #selector(handleDismis), for: .touchUpInside)
        return bt
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
     let floatingControlmainView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        setupTableViews()
        setupCloseButton()
        
        setupFloatinControls()
    }
   
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
        print(scrollView.contentOffset.y)
        
        let translationY = -90 - UIApplication.shared.statusBarFrame.height
        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            
            self.floatingControlmainView.transform = transform
        })
        
    }
    
    @objc func handleTapped(){
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.floatingControlmainView.transform = .init(translationX: 0, y: -90)
        })
    }
    
    func setupFloatinControls()  {
        floatingControlmainView.layer.cornerRadius = 16
        floatingControlmainView.clipsToBounds = true
        
        
        view.addSubview(floatingControlmainView)
        
        
        floatingControlmainView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 16, bottom: -90, right: 16),size: .init(width: 0, height: 90))
        
        let blurVisulEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.regular))
        floatingControlmainView.addSubview(blurVisulEffectView)
        blurVisulEffectView.fillSuperview()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
        
        // add our subviews
        let imageView = UIImageView(cornerRdius: 16)
        imageView.image = item?.image
        imageView.constrainHeight(constant: 68)
        imageView.constrainWidth(constant: 68)
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                UILabel(string: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                UILabel(string: "Utilizing your Time", font: .systemFont(ofSize: 16))
                ], spacing: 4),
            getButton
            ], customSpacing: 16)
        
        floatingControlmainView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
    
    
    
    //MARK: -UITableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let  cellHeader =  AppFullScreenHeaderCell()
            cellHeader.mainImageCell.todayItem = item
            cellHeader.mainImageCell.layer.cornerRadius = 0
            cellHeader.clipsToBounds = true
            return cellHeader
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AppFullScreenCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayVC.cellSize
        }
        //        return super.tableView(tableView, heightForRowAt: indexPath)
        return UITableView.automaticDimension
    }
    
    //MARK: -user methods
    
    func setupTableViews()  {
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(AppFullScreenCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 44, left: 0, bottom: 0, right: 8),size: .init(width: 80, height: 40))
    }
    
    //TODO: -handle methods
    
    @objc func handleDismis(sender: UIButton)  {
        sender.isHidden = true
        handleCloseClosure?()
    }
}
