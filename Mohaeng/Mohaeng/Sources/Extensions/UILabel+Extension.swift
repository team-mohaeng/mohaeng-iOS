//
//  UILabel+Extension.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/10.
//

import UIKit

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        if let text = self.text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            style.alignment = self.textAlignment
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
                
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func makeTyping(text: String, lineHeight: CGFloat = 24, highlightedText: String = "") {
        // label height와 highlightedText color 설정
        self.attributedText = NSMutableAttributedString(string: "")
        let combination = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .foregroundColor: UIColor.Black
        ]
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.Yellow3]
        
        // typing animation
        var textString = ""
        let characterDelay: TimeInterval = 5.0
        let writingTask = DispatchWorkItem { [weak self] in
            text.forEach { char in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    textString.append(char)
                    combination.append(NSAttributedString(string: "\(char)", attributes: attributes))
                    highlightedText.forEach { highlightedChar  in
                        let range = NSString(string: textString).range(of: "\(highlightedChar)", options: .caseInsensitive)
                        combination.addAttributes(highlightedAttributes, range: range)
                    }
                    self?.attributedText = combination
                    
              }
              Thread.sleep(forTimeInterval: characterDelay/100)
            }
          }
        
      let queue: DispatchQueue = .init(label: "typespeed", qos: .userInteractive)
      queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }
}
