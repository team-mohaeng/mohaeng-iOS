//
//  CourseFooterView.swift
//  Journey
//
//  Created by 초이 on 2021/08/25.
//

import UIKit

class CourseFooterView: UITableViewHeaderFooterView {
    
    enum IsDone {
        case done
        case undone
    }
    
    var isDone: IsDone?
    
    private let line = CAShapeLayer()

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var islandImageView: UIImageView!
    
    override func awakeFromNib() {
        initLastPath()
        setIslandImage()
    }
    
    func initLastPath() {
        let leftPath = RoadMapPath(centerY: 0).getVeryLastPath()
        
        line.fillMode = .forwards
        line.fillColor = UIColor.clear.cgColor
        line.lineWidth = 10.0
        line.path = leftPath.cgPath
        line.lineCap = .round
        
        switch isDone {
        case .done:
            line.lineDashPattern = [1]
            line.strokeColor = UIColor.sampleGreen.cgColor
        case .undone:
            line.lineDashPhase = 5
            line.lineDashPattern = [RoadMapPath(centerY: 0).getDashPattern(), RoadMapPath(centerY: 0).getBlankPattern()]
            line.strokeColor = UIColor.Grey4.cgColor
        case .none:
            return
        }
        
        self.bgView.layer.insertSublayer(line, at: 2)
    }
    
    func setIslandImage() {
        switch isDone {
        case .done:
            islandImageView.image = Const.Image.doneIsland
        case .undone:
            islandImageView.image = Const.Image.undoneIsland
        case .none:
            return
        }
    }

}
