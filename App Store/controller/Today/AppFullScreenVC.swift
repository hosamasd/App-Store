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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        setupTableViews()
       view.addSubview(closeButton)

        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 44, left: 0, bottom: 0, right: 8),size: .init(width: 80, height: 40))

    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
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
    
    //TODO: -handle methods
    
    @objc func handleDismis(sender: UIButton)  {
        sender.isHidden = true
        handleCloseClosure?()
    }
}
