//
//  CharacterStyleViewController.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/09/23.
//

import UIKit

import SnapKit
import Then

enum BackgroundSkin {
    
    case yellowBg
    case spreadBg
    case cloudBg
    case fieldBg
    case nightBg
    case figureBg
    
    func getOwnedSkinIcn() -> UIImage {
        switch self {
        case .yellowBg:
            return Const.Image.yellowBg
        case .spreadBg:
            return Const.Image.spreadBg
        case .cloudBg:
            return Const.Image.cloudBg
        case .fieldBg:
            return Const.Image.fieldBg
        case .nightBg:
            return Const.Image.nightBg
        case .figureBg:
            return Const.Image.figureBg
        }
    }
    
    func getLockSkinIcn() -> UIImage {
        switch self {
        case .yellowBg:
            return Const.Image.yellowLock
        case .spreadBg:
            return Const.Image.spreadLock
        case .cloudBg:
            return Const.Image.cloudLock
        case .fieldBg:
            return Const.Image.fieldLock
        case .nightBg:
            return Const.Image.nightLock
        case .figureBg:
            return Const.Image.figureLock
        }
    }
    
    func getSelectedSkinIcn() -> UIImage {
        switch self {
        case .yellowBg:
            return Const.Image.yellowSelected
        case .spreadBg:
            return Const.Image.spreadSelected
        case .cloudBg:
            return Const.Image.cloudSelected
        case .fieldBg:
            return Const.Image.fieldSelected
        case .nightBg:
            return Const.Image.nightSelected
        case .figureBg:
            return Const.Image.figureSelected
        }
    }
}

class CharacterStyleViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var charaterSelectView: UIView!
    @IBOutlet weak var charaterChoiceButton: UIButton!
    @IBOutlet weak var charaterTypeCollectionView: UICollectionView!
    @IBOutlet weak var charaterColorCollectionView: UICollectionView!
    @IBOutlet weak var backgroundSelectView: UIView!
    @IBOutlet weak var backgroundSelectButton: UIButton!
    @IBOutlet weak var backgroundSelectViewHeight: NSLayoutConstraint!
    @IBOutlet weak var choiceButtonTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    @IBOutlet weak var shadowView: UIView!
    
    // MARK: - Properties
    
    private var backgroundSkins: [BackgroundSkin] = [.yellowBg, .spreadBg, .cloudBg, .fieldBg, .nightBg, .figureBg]
    private var selectedSkinIndex: Int = 0
    private var selectedTypeIndex: Int = 0
    private var selectedColorIndex: Int = 0
    private var isOpen = false
    
    /// Dummy Properties
    var hasSkin: [Bool] = [true, true, false, true, false, true]
    var isNew: [Bool] = [false, false, false, false, false, true, false, true, false]
    var hasColor: [Bool] = [true, true, false, false, false, true, false, true, false]
    var isSelected: [Bool] = [true, false, false, false, false, false, false, false, false]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initConstraint()
        hideTabarController()
        registerXib()
        setDelegation()
        makeViewRounded()
        initViewShadow()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Functions
    
    private func initNavigationBar() {
        navigationController?.initWithBackButton()
        self.navigationItem.title = "캐릭터 스타일"
    }
    
    private func initConstraint() {
        choiceButtonTopSpacing.constant = 48 / 812 * UIScreen.main.bounds.height
    }
    
    private func hideTabarController() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func registerXib() {
        charaterTypeCollectionView.register(UINib(nibName: Const.Xib.Name.characterTypeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.characterTypeCollectionViewCell)
        charaterColorCollectionView.register(UINib(nibName: Const.Xib.Name.characterColorCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.characterColorCollectionViewCell)
        backgroundCollectionView.register(UINib(nibName: Const.Xib.Name.backgroundCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.backgroundCollectionViewCell)
    }
    
    private func setDelegation() {
        charaterColorCollectionView.delegate = self
        charaterColorCollectionView.dataSource = self
        charaterTypeCollectionView.delegate = self
        charaterTypeCollectionView.dataSource = self
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
    }
    
    private func makeViewRounded() {
        charaterChoiceButton.makeRounded(radius: charaterChoiceButton.bounds.height / 2)
        backgroundSelectView.makeRounded(radius: backgroundSelectView.bounds.height / 2)
        backgroundSelectButton.makeRounded(radius: backgroundSelectButton.bounds.height / 2)
        
        /// makeRoundedSpecificCorner 가 안먹어서 이 부분 코드리뷰 받고 수정할게요
        charaterSelectView.clipsToBounds = true
        charaterSelectView.layer.cornerRadius = 20
        charaterSelectView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private func initViewShadow() {
        shadowView.makeRounded(radius: shadowView.bounds.height / 2)
        shadowView.dropShadow(rounded: shadowView.bounds.height / 2)
    }
    
    private func updateConstraint() {
        if !UIDevice.current.hasNotch {
            backgroundSelectViewHeight.constant = isOpen ? 240 / 812 * UIScreen.main.bounds.height - 40 : 46
        } else {
            backgroundSelectViewHeight.constant = isOpen ? 240 / 812 * UIScreen.main.bounds.height : 46
        }
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchBackgroundToggleButton(_ sender: Any) {
        isOpen.toggle()
        updateConstraint()
        
        UIView.animate(withDuration: 0.6) { [self] in
            view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.6) { [self] in
            backgroundCollectionView.alpha = isOpen ? 1 : 0
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension CharacterStyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        switch collectionView {
        case charaterTypeCollectionView:
            let cellWidth = width * (60 / 375)
            let cellHeight = cellWidth * (60 / 60)
    
            return CGSize(width: cellWidth, height: cellHeight)
        case charaterColorCollectionView:
            let cellWidth = width * (100 / 375)
            let cellHeight = cellWidth * (120 / 100)
            
            return CGSize(width: cellWidth, height: cellHeight)
        case backgroundCollectionView:
            let cellWidth = width * (28 / 375)
            let cellHeight = cellWidth * (28 / 28)
            
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case charaterTypeCollectionView:
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        case charaterColorCollectionView:
            return UIEdgeInsets(top: 32, left: 24, bottom: 16, right: 24)
        case backgroundCollectionView:
            return UIEdgeInsets(top: 14, left: 0, bottom: 24, right: 0)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case charaterTypeCollectionView:
            return 20
        case charaterColorCollectionView:
            return 14
        case backgroundCollectionView:
            return 12
        default:
            return .zero
        }
    }
    
    /// 컬러 / 배경을 가지고 있지 않을 때 셀 선택 비활성화
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch collectionView {
        case charaterColorCollectionView:
            return hasColor[indexPath.row]
        case backgroundCollectionView:
            return hasSkin[indexPath.row]
        default:
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case charaterTypeCollectionView:
            selectedTypeIndex = indexPath.row
            charaterTypeCollectionView.reloadData()
        case charaterColorCollectionView:
            selectedColorIndex = indexPath.row
            charaterColorCollectionView.reloadData()
        case backgroundCollectionView:
            selectedSkinIndex = indexPath.row
            backgroundCollectionView.reloadData()
        default:
            return
        }
    }

}

// MARK: - UICollectionViewDataSource

extension CharacterStyleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case charaterTypeCollectionView:
            return 7
        case charaterColorCollectionView:
            return 9
        case backgroundCollectionView:
            return backgroundSkins.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case charaterTypeCollectionView:
            guard let cell = charaterTypeCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.characterTypeCollectionViewCell, for: indexPath) as? CharacterTypeCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.row == selectedTypeIndex {
                cell.showSelectView()
            } else {
                cell.hideSelectView()
            }
            
            return cell
        case charaterColorCollectionView:
            guard let cell = charaterColorCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.characterColorCollectionViewCell, for: indexPath) as? CharacterColorCollectionViewCell else { return UICollectionViewCell() }
            
            indicateIsNewColor(cell, indexPath: indexPath)
            indicateOwnedColor(cell, indexPath: indexPath)
            markCellSeletedState(cell, indexPath: indexPath)
            
            return cell
        case backgroundCollectionView:
            guard let cell = backgroundCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.backgroundCollectionViewCell, for: indexPath) as? BackgroundCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.row == selectedSkinIndex {
                cell.setData(image: backgroundSkins[indexPath.row].getSelectedSkinIcn())
            } else if hasSkin[indexPath.row] {
                cell.setData(image: backgroundSkins[indexPath.row].getOwnedSkinIcn())
            } else {
                cell.setData(image: backgroundSkins[indexPath.row].getLockSkinIcn())
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func indicateIsNewColor(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if isNew[indexPath.row] {
            cell.showNewIndicator()
        } else {
            cell.hideNewIndicator()
        }
    }
    
    func indicateOwnedColor(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if hasColor[indexPath.row] {
            cell.setUnlockCharacter()
        } else {
            cell.setLockCharacter()
        }
    }
    
    func markCellSeletedState(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if selectedColorIndex == indexPath.row {
            cell.showSelectedView()
            changeNewState(cell, indexPath: indexPath)
        } else {
            cell.showUnselectedView()
        }
    }
    
    func changeNewState(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if isNew[indexPath.row] {
            cell.hideNewIndicator()
            isNew[indexPath.row] = false
        }
    }
    
}
