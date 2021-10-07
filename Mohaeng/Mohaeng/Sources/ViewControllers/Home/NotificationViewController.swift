//
//  NotificationViewController.swift
//  Journey
//
//  Created by 초이 on 2021/08/30.
//

import UIKit

class NotificationViewController: UIViewController {
    
    // 더미데이터
    var noti = PushNoti(messages: [
        Message(date: "6일 전", message: ["아라아랑, 오늘 어땠어?", "많이 힘들었구나 ㅜㅜ", "챌린지 인증하고 푹 자자!"], isNew: false),
        Message(date: "5일 전", message: ["너의 안부에 스티커가 붙여졌어!"], isNew: false),
        Message(date: "4일 전", message: ["아라아랑, 오늘 어땠어?", "많이 힘들었구나 ㅜㅜ", "챌린지 인증하고 푹 자자!"], isNew: false),
        Message(date: "3일 전", message: ["너의 안부에 스티커가 붙여졌어!"], isNew: false),
        Message(date: "2일 전", message: ["너의 안부에 스티커가 붙여졌어!"], isNew: false),
        Message(date: "1일 전", message: ["아라아랑, 오늘 어땠어?", "많이 힘들었구나 ㅜㅜ", "챌린지 인증하고 푹 자자!"], isNew: false),
        Message(date: "1일 전", message: ["아라아랑, 오늘 어땠어?", "많이 힘들었구나 ㅜㅜ", "챌린지 인증하고 푹 자자!"], isNew: false),
        Message(date: "1시간 전", message: ["너의 안부에 스티커가 붙여졌어!"], isNew: false),
        Message(date: "1시간 전", message: ["너의 안부에 스티커가 붙여졌어!"], isNew: true),
        Message(date: "30분 전", message: ["아라아랑, 오늘 어땠어?", "많이 힘들었구나 ㅜㅜ", "챌린지 인증하고 푹 자자!"], isNew: true),
        Message(date: "30분 전", message: ["아라아랑, 오늘 어땠어?", "많이 힘들었구나 ㅜㅜ", "챌린지 인증하고 푹 자자!"], isNew: true),
        Message(date: "방금 전", message: ["초이초이", "초이초이ㅋㅋ", "와와와왕"], isNew: true)
    ])
    
    var oldNoti: [Message] = []
    var newNoti: [Message] = []
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var notificationCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        assignDelegate()
        registerXib()
        makeNewNotiArray(noti: noti)
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
        self.navigationItem.title = "알림"
    }
    
    private func assignDelegate() {
        notificationCollectionView.delegate = self
        notificationCollectionView.dataSource = self
    }
    
    private func registerXib() {
        notificationCollectionView.register(UINib(nibName: Const.Xib.Name.profileBubbleCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.profileBubbleCollectionViewCell)
        notificationCollectionView.register(UINib(nibName: Const.Xib.Name.bubbleCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.bubbleCollectionViewCell)
        notificationCollectionView.register(UINib(nibName: Const.Xib.Name.unreadNotificationHeaderView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.unreadNotificationHeaderView)
    }
    
    func makeNewNotiArray(noti: PushNoti) {
        for msg in noti.messages {
            
            for idx in 0..<msg.message.count {
                let newMsg = Message(date: idx == msg.message.count - 1 ? msg.date : "", message: [msg.message[idx]], isNew: msg.isNew)
                
                if msg.isNew {
                    newNoti.append(newMsg)
                } else {
                    oldNoti.append(newMsg)
                }
            }
            
        }
        
        notificationCollectionView.reloadData()
    }

}

// MARK: - UICollectionViewFlowLayout

extension NotificationViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - UICollectionViewDataSource

extension NotificationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // custom header view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Xib.Identifier.unreadNotificationHeaderView, for: indexPath)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        } else {
            return CGSize(width: view.frame.width, height: 60)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return oldNoti.count
        } else {
            return newNoti.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 첫 cell일 때
        if indexPath.row - 1 < 0 {
            // ProfileBubble
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.profileBubbleCollectionViewCell, for: indexPath) as? ProfileBubbleCollectionViewCell {
                
                if indexPath.section == 0 {
                    cell.setCell(msg: oldNoti[indexPath.row])
                } else {
                    cell.setCell(msg: newNoti[indexPath.row])
                }
                
                return cell
            }
            
        } else if indexPath.section == 1 && newNoti[indexPath.row - 1].date != "" {
            // 첫 메시지 - ProfileBubble
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.profileBubbleCollectionViewCell, for: indexPath) as? ProfileBubbleCollectionViewCell {
                
                cell.setCell(msg: newNoti[indexPath.row])
                
                return cell
            }
            
        } else if indexPath.section == 0 && oldNoti[indexPath.row - 1].date != "" {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.profileBubbleCollectionViewCell, for: indexPath) as? ProfileBubbleCollectionViewCell {
                
                cell.setCell(msg: oldNoti[indexPath.row])
                
                return cell
            }
            
        } else {
            // Bubble
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.bubbleCollectionViewCell, for: indexPath) as? BubbleCollectionViewCell {
                
                if indexPath.section == 0 {
                    cell.setCell(msg: oldNoti[indexPath.row])
                } else {
                    cell.setCell(msg: newNoti[indexPath.row])
                }
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 첫 cell일 때
        if indexPath.row - 1 < 0 {
            // ProfileBubble
            
            return CGSize(width: view.frame.width, height: 84)
            
        }
        
        if indexPath.section == 0 {
            // old Noti
            if oldNoti[indexPath.row-1].date != "" {
                // 첫 메시지 - ProfileBubble
                
                return CGSize(width: view.frame.width, height: 84)
                
            } else {
                // Bubble
                
                return CGSize(width: view.frame.width, height: 47)
            }
            
        } else {
            // new Noti
            if newNoti[indexPath.row-1].date != "" {
                // 첫 메시지 - ProfileBubble
                
                return CGSize(width: view.frame.width, height: 84)
                
            } else {
                // Bubble
                
                return CGSize(width: view.frame.width, height: 47)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
     
}
