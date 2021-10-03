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
        UIView.animateKeyframes(withDuration: 1, delay: 0) {
            [self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                sticker1Button.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1 / 6, relativeDuration: 0.5) {
                sticker2Button.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 2 / 6, relativeDuration: 0.5) {
                sticker3Button.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 3 / 6, relativeDuration: 0.5) {
                sticker4Button.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 4 / 6, relativeDuration: 0.5) {
                sticker5Button.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 5 / 6, relativeDuration: 0.5) {
                sticker6Button.alpha = 1
            }
        }
    }
    
    // MARK: - IBAction Properties
    
    @IBAction func touchCloseButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
