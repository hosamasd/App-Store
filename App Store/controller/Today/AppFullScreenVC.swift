//
//  AppFullScreenVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class AppFullScreenVC: UITableViewController {
    
    let cellId = "cellId"
    var item:TodayItem?
    
    var handleCloseClosure:(() ->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViews()
    }
    
    //MARK: -UITableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let  cellHeader =  AppFullScreenHeaderCell()
            cellHeader.mainImageCell.todayItem = item
            cellHeader.mainImageCell.layer.cornerRadius = 0
            
            cellHeader.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            return cellHeader
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AppFullScreenCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayVC.cellSize
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    //MARK: -user methods
    
    func setupTableViews()  {
        tableView.register(AppFullScreenCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    
    //TODO: -handle methods
    
    @objc func handleDismiss(sender: UIButton)  {
        sender.isHidden = true
        handleCloseClosure?()
    }
}
