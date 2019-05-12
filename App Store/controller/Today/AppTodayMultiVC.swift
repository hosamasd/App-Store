//
//  AppTodayMultiVC.swift
//  App Store
//
//  Created by hosam on 5/11/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit


//dependency injection in this VC also

class AppTodayMultiVC: BaseListController {
    
    fileprivate let cellId = "cellId"
    var appResult = [FeedResult]()
     fileprivate let spacing: CGFloat = 16
    lazy var closeButton:UIButton = {
        let bt = UIButton()
        bt.setImage(#imageLiteral(resourceName: "close_button").withRenderingMode(.alwaysOriginal), for: .normal)
        bt.addTarget(self, action: #selector(handleDimiss), for: .touchUpInside)
        return bt
    }()
    
    //dependency
   fileprivate let mode:Mode
    
    enum Mode {
        case small,fullScreen
    }
    
     init(mode:Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullScreen {
            setupCloseButton()
            self.navigationController?.isNavigationBarHidden = true
        }else {
             collectionView.isScrollEnabled = false
        }
         setupCollectionViews()
     }
    
    override var prefersStatusBarHidden: Bool{ return true }
  
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullScreen {
            return appResult.count
        }
        return  min(4, appResult.count)
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppTodayMultiCell
        let app = appResult[indexPath.item]

        cell.appFeeds = app
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullScreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//         let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        let height:CGFloat = 68
        if mode == .fullScreen {
            return CGSize(width: view.frame.width - 48, height: height)
        }
         return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = self.appResult[indexPath.item].id
       let appDetails = AppDetailVC(appId: appId)
        navigationController?.pushViewController(appDetails, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
   
    //MARK: -user methods
   
    func setupCloseButton()  {
        view.addSubview(closeButton)
        
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 16, left: 0, bottom: 0, right: 8),size: .init(width: 44, height: 44))
    }
    
    fileprivate func setupCollectionViews() {
        collectionView.backgroundColor = .white
        collectionView.register(AppTodayMultiCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //TODO: -handle methods
    
    @objc func handleDimiss()  {
        dismiss(animated: true)
    }
}
