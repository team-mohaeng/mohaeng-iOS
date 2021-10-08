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
    
    // MARK: - IBAction Properties
    
    @IBAction func touchCloseButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
