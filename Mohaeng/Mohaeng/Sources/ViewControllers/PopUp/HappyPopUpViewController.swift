//
//  HappyPopUpViewController.swift
//  Journey
//
//  Created by 초이 on 2021/07/14.
//

import UIKit

class HappyPopUpViewController: UIViewController {
    
    // MARK: - Properties
    
    var mood: Int = 2
    var hasImage: Bool = true
    var image: UIImage?
    var delegate: PopUpActionDelegate?
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moodImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var shareToDescriptionVSpacing: NSLayoutConstraint!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewRounding()
        setMoodImage(by: mood)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUploadedImage(hasImage: true, image: image)
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        shareButton.makeRounded(radius: shareButton.frame.height / 2)
        saveButton.makeRounded(radius: saveButton.frame.height / 2)
        popUpView.makeRounded(radius: 20)
        uploadedImageView.makeRounded(radius: 4)
    }
    
    private func setMoodImage(by mood: Int) {
        switch mood {
        case 0:
            moodImageView.image = Const.Image.happyCFaceGraphic1
        case 1:
            moodImageView.image = Const.Image.happyCFaceGraphic2
        case 2:
            moodImageView.image = Const.Image.happyCFaceGraphic3
        default:
            return
        }
    }
    
    private func setUploadedImage(hasImage: Bool, image: UIImage?) {
        if !hasImage {
            uploadedImageView.removeFromSuperview()
            shareToDescriptionVSpacing.constant = 29
        } else {
            uploadedImageView.image = image
        }
    }
    
    // MARK: - @IBAction Functions

    @IBAction func touchShareButton(_ sender: UIButton) {
        self.delegate?.touchPinkButton(button: sender)
    }
    
    @IBAction func touchSaveButton(_ sender: UIButton) {
        self.delegate?.touchWhiteButton(button: sender)
    }
    
}
