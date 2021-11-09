//
//  NotificationViewController.swift
//  Journey
//
//  Created by 초이 on 2021/08/30.
//

import UIKit

class NotificationViewController: UIViewController {
    
    // 더미데이터
    var noti = PushNoti(profileImg: "", messages: [])
    
    var oldNoti: [Message] = []
    var newNoti: [Message] = []
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var notificationCollectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegate()
        registerXib()
        getNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initNavigationBar()
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton(backgroundColor: .YellowBg1)
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
            
            // date 변환
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_kr") as Locale
            dateFormatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
            let start = dateFormatter.date(from: msg.date)!
            let end = Date()
            
            let calendar = Calendar.current
            
            let dayBefore = calendar.dateComponents([.day], from: start, to: end)
            
            // day String
            var dayString = ""
            if dayBefore.day == 0 {
                let minBefore = calendar.dateComponents([.minute], from: start, to: end)
                let hourBefore = calendar.dateComponents([.hour], from: start, to: end)
                
                if hourBefore.hour == 0 && minBefore.minute! <= 30 {
                    dayString = "방금 전"
                } else if hourBefore.hour == 0 && minBefore.minute! <= 59 {
                    dayString = "1시간 전"
                } else {
                    dayString = "\(hourBefore.hour ?? 1)시간 전"
                }
            } else {
                dayString = "\(dayBefore.day ?? 1)일 전"
            }
            
            // create new arrays
            for idx in 0..<msg.message.count {
                let newMsg = Message(date: idx == msg.message.count - 1 ? dayString : "", message: [msg.message[idx]], isNew: msg.isNew)
                
                if msg.isNew {
                    newNoti.append(newMsg)
                } else {
                    oldNoti.append(newMsg)
                }
            }
            
            if !newNoti.isEmpty || !oldNoti.isEmpty {
                emptyLabel.isHidden = true
            }
        }
        
        notificationCollectionView.reloadData()
        
        // scroll to bottom
        if newNoti.isEmpty {
            notificationCollectionView.scrollToItem(at: IndexPath(item: oldNoti.count-1, section: 0), at: .bottom, animated: false)
        } else {
            notificationCollectionView.scrollToItem(at: IndexPath(item: newNoti.count-1, section: 1), at: .bottom, animated: false)
        }
    }
    
    // 서버 통신 후 데이터 업데이트
    func updateData(data: PushNoti) {
        noti = data
        makeNewNotiArray(noti: noti)
    }
    
    func getBoundingRect(string: String) -> CGRect {
        let textRect = NSString(string: string).boundingRect(
            with: CGSize(width: 200, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [
                NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(weight: .regular, size: 15)
            ],
            context: nil)
        return textRect
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
            if newNoti.isEmpty {
                return CGSize.zero
            } else {
                return CGSize(width: view.frame.width, height: 60)
            }
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
                cell.setProfileImage(url: noti.profileImg)
                
                return cell
            }
            
        } else if indexPath.section == 1 && newNoti[indexPath.row - 1].date != "" {
            // 첫 메시지 - ProfileBubble
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.profileBubbleCollectionViewCell, for: indexPath) as? ProfileBubbleCollectionViewCell {
                
                cell.setCell(msg: newNoti[indexPath.row])
                cell.setProfileImage(url: noti.profileImg)
                
                return cell
            }
            
        } else if indexPath.section == 0 && oldNoti[indexPath.row - 1].date != "" {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.profileBubbleCollectionViewCell, for: indexPath) as? ProfileBubbleCollectionViewCell {
                
                cell.setCell(msg: oldNoti[indexPath.row])
                cell.setProfileImage(url: noti.profileImg)
                
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
        
        // dynamic height를 위한 label boundingRect 계산
        var textSize = CGRect()
        if indexPath.section == 0 {
            textSize = getBoundingRect(string: oldNoti[indexPath.row].message[0])
        } else {
            textSize = getBoundingRect(string: newNoti[indexPath.row].message[0])
        }
        
        // 첫 cell일 때
        if indexPath.row - 1 < 0 {
            // ProfileBubble
            
            return CGSize(width: view.frame.width, height: textSize.height + 70)
        }
        
        if indexPath.section == 0 {
            // old Noti
            if oldNoti[indexPath.row-1].date != "" {
                // 첫 메시지 - ProfileBubble
                
                return CGSize(width: view.frame.width, height: textSize.height + 70)
                
            } else {
                // Bubble
                
                return CGSize(width: view.frame.width, height: textSize.height + 30)
            }
            
        } else {
            // new Noti
            if newNoti[indexPath.row-1].date != "" {
                // 첫 메시지 - ProfileBubble
                
                return CGSize(width: view.frame.width, height: textSize.height + 70)
                
            } else {
                // Bubble
                
                return CGSize(width: view.frame.width, height: textSize.height + 30)
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

// MARK: - 통신

extension NotificationViewController {
    
    func getNotification() {
        
        PushNotiAPI.shared.getNotifications { (response) in
            
            switch response {
            case .success(let data):
                
                if let data = data as? PushNoti {
                    self.updateData(data: data)
                }
                
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
