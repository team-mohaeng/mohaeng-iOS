//
//  AnimationFactory.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/12.
//

import UIKit

typealias TableViewAnimation = (UITableViewCell, IndexPath, UITableView) -> Void

enum AnimationFactory {
    static func makeMoveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delayFactor: Double) -> TableViewAnimation {
        return { cell, indexPath, _ in
            cell.transform = CGAffineTransform(translationX: 0, y: rowHeight / 2)
            cell.alpha = 0

            UIView.animate(
                withDuration: duration,
                delay: delayFactor * Double(indexPath.row),
                options: [.curveEaseInOut],
                animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
            })
        }
    }
}

final class Animator {
    private let animation: TableViewAnimation

    init(animation: @escaping TableViewAnimation) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {

        animation(cell, indexPath, tableView)
    }
}
