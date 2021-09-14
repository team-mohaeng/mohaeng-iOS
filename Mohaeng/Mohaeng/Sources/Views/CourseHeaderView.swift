//
//  CourseHeaderView.swift
//  Journey
//
//  Created by 초이 on 2021/08/25.
//

import UIKit

class CourseHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var headerBgView: UIView!
    @IBOutlet weak var dayBgView: UIView!
    
    override func awakeFromNib() {
        initViewRounding()
    }
    
    private func initViewRounding() {
        dayBgView.makeRounded(radius: dayBgView.frame.height / 2)
    }

}
