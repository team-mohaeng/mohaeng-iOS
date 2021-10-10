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
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: (lineHeight - font.lineHeight) / 4
            ]
                
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
    
    func setTyping(text: String, lineHeight: CGFloat = 24, highlightedText: String = "") {
        self.attributedText = NSMutableAttributedString(string: "")
        let combination = NSMutableAttributedString()
        let style = NSMutableParagraphStyle()
        style.maximumLineHeight = lineHeight
        style.minimumLineHeight = lineHeight
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font.lineHeight) / 4
        ]
        let highlightedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.Yellow3]
        
        var textString = ""
        let characterDelay: TimeInterval = 5.0
        let writingTask = DispatchWorkItem { [weak self] in
            text.forEach { char in
                DispatchQueue.main.async {
                    textString.append(char)
                    combination.append(NSAttributedString(string: "\(char)", attributes: attributes))
                    self?.attributedText = combination
                    let range = NSString(string: textString).range(of: highlightedText, options: .caseInsensitive)
                    combination.addAttributes(highlightedAttributes, range: range)
              }
              Thread.sleep(forTimeInterval: characterDelay/100)
            }
          }
        
      let queue: DispatchQueue = .init(label: "typespeed", qos: .userInteractive)
      queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }
}
