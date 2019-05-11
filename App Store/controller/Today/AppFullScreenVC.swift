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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        
        if indexPath.row == 0 {
            //hacking
            let cell = UITableViewCell()
            let dumyCell = TodayCell()
            cell.addSubview(dumyCell)
            dumyCell.centerInSuperview(size: .init(width: 250, height: 250))
            return cell
        }
        
         cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AppFullScreenCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }

    
    func setupTableViews()  {
        tableView.register(AppFullScreenCell.self, forCellReuseIdentifier: cellId)
    }
}
