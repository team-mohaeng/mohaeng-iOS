//
//  FeedHeaderView.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/03.
//

import UIKit

class FeedHeaderView: UIView {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var myDrawerButton: UIButton!
    @IBOutlet weak var writeButtonView: UIView!
    @IBOutlet weak var writeButtonImageView: UIImageView!
    @IBOutlet weak var writeButtonLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
       super.awakeFromNib()
        initAttributes()
        addWriteTouchEvent()
        addObserver()
    }
    
    // MARK: - function
    
    private func initAttributes() {
        writeButtonView.makeRounded(radius: writeButtonView.frame.height / 2)
    }
    
    private func addWriteTouchEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchWriteButton(sender:)))
        writeButtonView.addGestureRecognizer(tapGesture)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(initWriteButton), name: NSNotification.Name("sendServerData"), object: nil)
    }

    @objc private func initWriteButton(notification: Notification) {
        // 0: 소확행 작성 불가능, 1: 소확행 작성 가능, 2: 소확행 작성완료
        guard let writeStatus = notification.object as? FeedData else { return }
        switch writeStatus.hasSmallSatisfaction {
        case 0:
            writeButtonLabel.textColor = .Black3Text
            writeButtonImageView.image = UIImage(named: "imgLock")
        case 1:
            writeButtonLabel.textColor = .Black1Text
            writeButtonImageView.image = UIImage(named: "imgUnlock")
        case 2:
            writeButtonLabel.textColor = .Black1Text
            writeButtonImageView.image = UIImage(named: "iconCongratulations")
            writeButtonLabel.text = "소확행 작성완료"
        default:
            break
        }
    }
    
    // MARK: - @IBAction
    
    @IBAction func touchMyDrawerButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("myDrawerCilcked"), object: nil)
    }
   
    @objc private func touchWriteButton(sender: UIGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name("writeHappinessClicked"), object: nil)
    }
}
