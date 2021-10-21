//
//  StickerViewController.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/10/03.
//

import UIKit

class StickerViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var sticker1Button: UIButton!
    @IBOutlet weak var sticker2Button: UIButton!
    @IBOutlet weak var sticker3Button: UIButton!
    @IBOutlet weak var sticker4Button: UIButton!
    @IBOutlet weak var sticker5Button: UIButton!
    @IBOutlet weak var sticker6Button: UIButton!
    
    // MARK: - Properties
    
    var postId = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initStickerAnimation()
    }
    
    // MARK: - Functions
    
    func initStickerAnimation() {
        let stickerButtons: [UIButton] = [sticker1Button, sticker2Button, sticker3Button, sticker4Button, sticker5Button, sticker6Button]
        UIView.animateKeyframes(withDuration: 1, delay: 0) {
            for index in 0..<stickerButtons.count {
                UIView.addKeyframe(withRelativeStartTime: Double(index) / 6, relativeDuration: 1 / 3) {
                    stickerButtons[index].alpha = 1
                }
            }
        }
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("stickerButtonDidTap"),
                                        object: nil,
                                        userInfo: nil)
    }
    
    // MARK: - IBAction Properties
    
    @IBAction func touchCloseButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func touchSticker1(_ sender: Any) {
        postEmoji(emojiId: 1, postId: postId)
    }
    
    @IBAction func touchSticker2(_ sender: Any) {
        postEmoji(emojiId: 2, postId: postId)
    }
    
    @IBAction func touchSticker3(_ sender: Any) {
        postEmoji(emojiId: 3, postId: postId)
    }
    
    @IBAction func touchSticker4(_ sender: Any) {
        postEmoji(emojiId: 4, postId: postId)
    }
    
    @IBAction func touchSticker5(_ sender: Any) {
        postEmoji(emojiId: 5, postId: postId)
    }
    
    @IBAction func touchSticker6(_ sender: Any) {
        postEmoji(emojiId: 6, postId: postId)
    }
    
}

extension StickerViewController {
    
    func postEmoji(emojiId: Int, postId: Int) {
        FeedAPI.shared.postEmoji(emojiId: emojiId, postId: postId) { response in
            switch response {
            case .success:
                self.dismiss(animated: false) {
                    self.postNotification()
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
