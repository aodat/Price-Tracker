//
//  BaseCollectionViewController.swift
//  Price Tracker
//
//  Created by Abdalla Odat on 8/1/17.
//  Copyright © 2017 Abdalla Odat. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BaseCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        leftItemBarButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftItemBarButton (){
        let settingButton = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(BaseCollectionViewController.goToProductTypes ))
        self.navigationItem.leftBarButtonItem  = settingButton
    }
    
    func goToProductTypes (){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeTabViewController = mainStoryboard.instantiateViewController(withIdentifier: "ProductTypes")
        present(homeTabViewController, animated: true, completion: nil)
    }
    
    
    
    
}
