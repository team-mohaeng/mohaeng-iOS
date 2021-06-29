//
//  OddDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class OddDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let startPoint: CGPoint = CGPoint(x: 47 + 75, y: -10)
    let endPoint: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 47 - 75, y: 188 - 75 - 48)
    let endPoint2: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 47 - 75, y: 188 - 48)
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var propertyBgView: UIView!
    @IBOutlet weak var propertyImageView: UIImageView!
    
    // MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initEvenPath()
        initViewRounding()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
    }
    
    private func initEvenPath() {
        let line = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: startPoint)
        
        path.addArc(withCenter: startPoint, radius: 75, startAngle: -CGFloat.pi, endAngle: CGFloat.pi / 2, clockwise: false)
        
        path.addLine(to: endPoint)
        
        path.addArc(withCenter: endPoint2, radius: 75, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
        
        line.fillMode = .forwards
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = UIColor.white.cgColor
        line.lineWidth = 20.0
        line.path = path.cgPath
        
        self.contentView.layer.insertSublayer(line, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
