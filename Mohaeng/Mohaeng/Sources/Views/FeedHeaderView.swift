//
//  FeedHeaderView.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/03.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func touchMyDrawerButton()
    func touchWritingButton()
}

class FeedHeaderView: UIView {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var newIndicatorView: UIView!
    @IBOutlet weak var myDrawerButtonView: UIView!
    
    // MARK: - Properties
    
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initAttributes()
        addTouchEventToMyDrawerView()
    }
    
    // MARK: - function
    
    private func initAttributes() {
        newIndicatorView.makeRounded(radius: newIndicatorView.frame.height / 2)
    }
    
    private func setNewIndicator(isNew: Bool) {
        if isNew {
            newIndicatorView.isHidden = false
        } else {
            newIndicatorView.isHidden = true
        }
    }
    
    func setHeaderData(hasNewContents: Bool, contents: Int) {
        setNewIndicator(isNew: hasNewContents)
    }
    
    private func addTouchEventToMyDrawerView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchMyDrawerButton(_:)))
        myDrawerButtonView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - @IBAction functions
    
    @IBAction func touchWriteButton(_ sender: Any) {
        delegate?.touchWritingButton()
    }
    
    // MARK: - @objc functions
    
    @objc
    private func touchMyDrawerButton(_ sender: UITapGestureRecognizer) {
        delegate?.touchMyDrawerButton()
    }
}
