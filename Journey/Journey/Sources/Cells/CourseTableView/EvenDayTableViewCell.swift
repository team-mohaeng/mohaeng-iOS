//
//  EvenDayTableViewCell.swift
//  Journey
//
//  Created by 초이 on 2021/06/29.
//

import UIKit

class EvenDayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let startPoint: CGPoint = CGPoint(x: UIScreen.main.bounds.width - 47 - 75, y: -10)
    let endPoint: CGPoint = CGPoint(x: 47 + 75, y: 188 - 75 - 48)
    let endPoint2: CGPoint = CGPoint(x: 47 + 75, y: 188 - 48)
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var propertyBgView: UIView!
    @IBOutlet weak var propertyImageView: UIView!
    
    // MARK: - View Life Cycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViewRounding()
        initEvenPath()
    }
    
    // MARK: - Functions
    
    private func initViewRounding() {
        propertyBgView.makeRounded(radius: propertyBgView.frame.height / 2)
    }
    
    private func initEvenPath() {
        let line = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addArc(withCenter: startPoint, radius: 75, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
        
        path.addLine(to: endPoint)
        
        path.addArc(withCenter: endPoint2, radius: 75, startAngle: -CGFloat.pi / 2, endAngle: -CGFloat.pi, clockwise: false)
        
        line.fillMode = .forwards
        line.fillColor = UIColor.clear.cgColor
        line.strokeColor = UIColor.Pink.cgColor
        line.lineWidth = 20.0
        line.path = path.cgPath
        
        cellBgView.layer.insertSublayer(line, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
