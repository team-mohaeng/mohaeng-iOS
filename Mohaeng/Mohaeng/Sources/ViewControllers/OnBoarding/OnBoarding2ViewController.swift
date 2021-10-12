//
//  OnBoarding2ViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/10.
//

import UIKit

import SnapKit
import Then

class OnBoarding2ViewController: UIViewController {
    
// MARK: - Properties
    
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.backgroundColor = .White
    }
    
// MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        iniViewController()
        setDelegation()
        registerTableViewCell()
        setLayout()
    }
    
// MARK: - Functions
    
    private func iniViewController() {
        view.backgroundColor = .White
    }
    
    private func setDelegation() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setViewHierachy() {
        view.addSubviews(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    private func registerTableViewCell() {
        tableView.register(OnBoarding2TableViewCell.self, forCellReuseIdentifier: OnBoarding2TableViewCell.identifier)
    }

}

// MARK: - UITableViewDataSource

extension OnBoarding2ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnBoarding2TableViewCell.identifier, for: indexPath) as? OnBoarding2TableViewCell
        else { return UITableViewCell() }
        cell.course = AppCourse(rawValue: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: 200, duration: 2, delayFactor: 0)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}

// MARK: - UITableViewDelegate

extension OnBoarding2ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return OnBoarding2HeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = OnBoarding3ViewController()
        viewController.course = AppCourse(rawValue: indexPath.row)
        viewController.isDone = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
