//
//  MakersViewController.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/11/04.
//

import UIKit

class MakersViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet var mohaengImageTrailing: NSLayoutConstraint!
    @IBOutlet var mohaengLabel: UILabel!
    @IBOutlet var partLabels: [UILabel]!
    @IBOutlet var nameLabels: [UILabel]!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setConstraintWitouthNotch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Functions
    
    func setConstraintWitouthNotch() {
        mohaengImageTrailing.constant = UIDevice.current.hasNotch ? 0 : 10
    }
    
    func setUI() {
        partLabels.forEach {
            $0.makeRounded(radius: 14)
            $0.font = .spoqaHanSansNeo(weight: .medium, size: 14)
        }
        nameLabels.forEach {
            $0.font = .gmarketFont(weight: .medium, size: 16)
        }
        
        mohaengLabel.font = .gmarketFont(weight: .medium, size: 24)
    }

}
