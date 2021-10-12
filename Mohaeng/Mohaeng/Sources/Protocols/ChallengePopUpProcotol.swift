//
//  ChallengePopUpProcotol.swift
//  Mohaeng
//
//  Created by 초이 on 2021/10/10.
//

import Foundation
import UIKit

protocol ChallengePopUpProtocol: AnyObject {
    func touchHelpButton(_ sender: UIButton)
    func touchStampButton(_ sender: UITapGestureRecognizer)
    func pushToFinishViewController()
    func pushToNextOnboardingViewController()
}
