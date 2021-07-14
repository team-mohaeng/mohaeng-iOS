//
//  ChallengeViewController.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class ChallengeViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var stampView: UIView!
    @IBOutlet weak var stampStackView: UIStackView!
    @IBOutlet weak var triangleStampView: UIView!
    @IBOutlet weak var challengeTitleLabel: UILabel!
    @IBOutlet weak var challengeSubTitleLabel: UILabel!
    @IBOutlet weak var stampImageView1: UIImageView!
    @IBOutlet weak var stampImageView2: UIImageView!
    @IBOutlet weak var stampImageView3: UIImageView!
    @IBOutlet weak var triangleStampImageView1: UIImageView!
    @IBOutlet weak var triangleStampImageView2: UIImageView!
    @IBOutlet weak var triangleStampImageView3: UIImageView!
    @IBOutlet weak var stampStatusLabel: UILabel!
    @IBOutlet weak var challengeDescriptionLabel: UILabel!
    @IBOutlet weak var journeyNameView: UIView!
    @IBOutlet weak var journeyDescriptionView: UIView!
    @IBOutlet weak var viewToImage: NSLayoutConstraint!
    @IBOutlet weak var challengeToStampViewBottom: NSLayoutConstraint!
    @IBOutlet weak var subtitleToTitle: NSLayoutConstraint!
    @IBOutlet weak var stampWidth: NSLayoutConstraint!
    @IBOutlet weak var stackviewToChallengeLabel: NSLayoutConstraint!
    @IBOutlet weak var underTriangleStackViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var totalStamp = 2
    var stampTouchCount = 0
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initJourneyView()
        initStampBackgroundView()
        addtouchGesture()
        notchCase()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        stampWidth.constant = triangleStampView.frame.height / 2
        underTriangleStackViewHeight.constant = triangleStampView.frame.height / 2
    }
    
    // MARK: - Functions
    
    private func initJourneyView() {
        journeyNameView.makeRounded(radius: journeyNameView.frame.height / 2)
        journeyDescriptionView.makeRoundedSpecificCorner(corners: [.bottomLeft, .bottomRight, .topRight], cornerRadius: 25)
    }
    
    private func initStampBackgroundView() {
        stampView.makeRounded(radius: 18)
    }
    
    private func addtouchGesture() {
        let stampGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchstampAction1(_:)))
        stampImageView1.isUserInteractionEnabled = true
        stampImageView1.addGestureRecognizer(stampGesture)
        
        let stampGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.touchstampAction2(_:)))
        stampImageView2.isUserInteractionEnabled = true
        stampImageView2.addGestureRecognizer(stampGesture2)
        
        let stampGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.touchstampAction3(_:)))
        stampImageView3.isUserInteractionEnabled = true
        stampImageView3.addGestureRecognizer(stampGesture3)
        
        let stampGesture4 = UITapGestureRecognizer(target: self, action: #selector(self.touchStampActionTriangle1(_:)))
        triangleStampImageView1.isUserInteractionEnabled = true
        triangleStampImageView1.addGestureRecognizer(stampGesture3)
        
        let stampGesture5 = UITapGestureRecognizer(target: self, action: #selector(self.touchStampActionTriangle2(_:)))
        triangleStampImageView2.isUserInteractionEnabled = true
        triangleStampImageView2.addGestureRecognizer(stampGesture3)
        
        let stampGesture6 = UITapGestureRecognizer(target: self, action: #selector(self.touchStampActionTriangle3(_:)))
        triangleStampImageView3.isUserInteractionEnabled = true
        triangleStampImageView3.addGestureRecognizer(stampGesture3)
    }
    
    private func notchCase() {
        if UIDevice.current.hasNotch {
            switch totalStamp {
            case 1:
                stampImageView2.isHidden = true
                stampImageView3.isHidden = true
                viewToImage.constant = 22
                challengeToStampViewBottom.constant = 60
                triangleStampView.isHidden = true
            case 2:
                stampImageView3.isHidden = true
                triangleStampView.isHidden = true
                viewToImage.constant = 22
                stackviewToChallengeLabel.constant = 47
                challengeToStampViewBottom.constant = 62
            case 3:
                stampStackView.isHidden = true
                
            default:
                break
            }
            
        } else {
            switch totalStamp {
            case 1:
                stampImageView2.isHidden = true
                stampImageView3.isHidden = true
                triangleStampView.isHidden = true
            case 2:
                stampImageView3.isHidden = true
                triangleStampView.isHidden = true
                viewToImage.constant = 22
                challengeToStampViewBottom.constant = 62
                stackviewToChallengeLabel.constant = 47
            case 3:
                triangleStampView.isHidden = true
                stackviewToChallengeLabel.constant = 41
                challengeToStampViewBottom.constant = 39
                viewToImage.constant = 11
            default:
                break
            }
        }
        
    }

    // MARK: - Action Properties
    
    @objc func touchstampAction1(_ gesture: UITapGestureRecognizer) {
        print("수")
        
    }
    
    @objc func touchstampAction2(_ gesture: UITapGestureRecognizer) {
        print("정")
        
    }
    
    @objc func touchstampAction3(_ gesture: UITapGestureRecognizer) {
        print("할")
        
    }
    
    @objc func touchStampActionTriangle1(_ gesture: UITapGestureRecognizer) {
        print("게")
        
    }
    
    @objc func touchStampActionTriangle2(_ gesture: UITapGestureRecognizer) {
        print("요")
        
    }
    
    @objc func touchStampActionTriangle3(_ gesture: UITapGestureRecognizer) {
        print("ㅋ")
        
    }
    
}
