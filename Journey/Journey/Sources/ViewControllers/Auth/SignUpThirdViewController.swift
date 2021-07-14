//
//  SignUpThirdViewController.swift
//  Journey
//
//  Created by 김승찬 on 2021/07/06.
//

import UIKit

class SignUpThirdViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var inputNicknameTextField: UITextField!
    @IBOutlet weak var touchNextPage3Button: UIButton!
    @IBOutlet weak var serviceLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUnderLineinputNicknameTextField()
        makeButton3Round()
        chgangeTextAttribute()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeUnderLineinputNicknameTextField()
      
    }
    
    // MARK: - Functions
    
    private func makeUnderLineinputNicknameTextField() {
        inputNicknameTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: inputNicknameTextField.frame.size.height-1, width: inputNicknameTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        inputNicknameTextField.layer.addSublayer((border))
        inputNicknameTextField.textColor = UIColor.black
    }
    
    private func makeButton3Round() {
        touchNextPage3Button.makeRounded(radius: 24)
    }
    
    private func chgangeTextAttribute() {
        //serviceLabel 텍스트 가져오기
        guard let text = self.serviceLabel.text else { return }
        
        // 인스턴스 만들어주기
        let attributeString = NSMutableAttributedString(string: text)
        
        // 크기 폰트 생성
        let font = UIFont.boldSystemFont(ofSize: 10)
        
        // 내가 원하는 텍스트에만 적용
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "서비스 이용 약관"))
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "개인정보 보호정책"))
        
        // 밑줄 색
        attributeString.addAttribute(.underlineColor, value: UIColor.black, range: (text as NSString).range(of: "서비스 이용 약관"))
        attributeString.addAttribute(.underlineColor, value: UIColor.black, range: (text as NSString).range(of: "개인정보 보호정책"))
        
        // 밑줄 두께
        attributeString.addAttribute(.underlineStyle, value: 1, range: (text as NSString).range(of: "서비스 이용 약관"))
        attributeString.addAttribute(.underlineStyle, value: 1, range: (text as NSString).range(of: "개인정보 보호정책"))
        
        // 속성 적용
        self.serviceLabel.attributedText = attributeString
        
    }

}
