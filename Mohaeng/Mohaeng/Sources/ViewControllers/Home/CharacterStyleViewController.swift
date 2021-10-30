//
//  CharacterStyleViewController.swift
//  Mohaeng
//
//  Created by 윤예지 on 2021/09/23.
//

import UIKit

import SnapKit
import Then

class CharacterStyleViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var characterSelectView: UIView!
    @IBOutlet weak var characterChoiceButton: UIButton!
    @IBOutlet weak var characterTypeCollectionView: UICollectionView!
    @IBOutlet weak var characterCardCollectionView: UICollectionView!
    @IBOutlet weak var backgroundSelectView: UIView!
    @IBOutlet weak var backgroundSelectButton: UIButton!
    @IBOutlet weak var backgroundSelectViewHeight: NSLayoutConstraint!
    @IBOutlet weak var choiceButtonTopSpacing: NSLayoutConstraint!
    @IBOutlet weak var backgroundCollectionView: UICollectionView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var characterImageView: UIImageView!
    
    // MARK: - Properties
    
    private var backgroundSkins: [BackgroundSkin] = [.yellowBg, .spreadBg, .cloudBg, .fieldBg, .nightBg, .figureBg]
    private var selectedSkinIndex: Int = 0
    private var selectedTypeIndex: Int = 0
    private var selectedCardIndex: Int = 0
    private var allCardSelectedInfo: [[Bool]] = Array(repeating: Array(repeating: false, count: 9), count: 7)
    private var isOpen = false
    private var selectedCardId: Int = 0
    private var characterData: CharacterStyle = CharacterStyle(currentCharacter: Current(id: 0, image: ""), currentSkin: Current(id: 0, image: ""), characters: [Character(type: 0, cards: [Card]())], skins: [Skin(id: 0, image: "", hasSkin: false)])
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserCharacterInfo()
        initNavigationBar()
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
    
    private func setCurrentCharacterCellSelect(typeIndex: Int, cardIndex: Int) {
        allCardSelectedInfo[typeIndex][cardIndex - 1] = true
        characterCardCollectionView.reloadData()
    }
    
    private func initNavigationBar() {
        navigationController?.initWithBackButton()
        self.navigationItem.title = "캐릭터 스타일"
    }
    
    private func hideTabarController() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func registerXib() {
        characterTypeCollectionView.register(UINib(nibName: Const.Xib.Name.characterTypeCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.characterTypeCollectionViewCell)
        characterCardCollectionView.register(UINib(nibName: Const.Xib.Name.characterColorCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.characterColorCollectionViewCell)
        backgroundCollectionView.register(UINib(nibName: Const.Xib.Name.backgroundCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Const.Xib.Identifier.backgroundCollectionViewCell)
    }
    
    private func setDelegation() {
        characterCardCollectionView.delegate = self
        characterCardCollectionView.dataSource = self
        characterTypeCollectionView.delegate = self
        characterTypeCollectionView.dataSource = self
        backgroundCollectionView.delegate = self
        backgroundCollectionView.dataSource = self
    }
    
    private func makeViewRounded() {
        characterChoiceButton.makeRounded(radius: characterChoiceButton.bounds.height / 2)
        backgroundSelectView.makeRounded(radius: backgroundSelectView.bounds.height / 2)
        backgroundSelectButton.makeRounded(radius: backgroundSelectButton.bounds.height / 2)
        
        /// makeRoundedSpecificCorner 가 안먹어서 이 부분 코드리뷰 받고 수정할게요
        characterSelectView.clipsToBounds = true
        characterSelectView.layer.cornerRadius = 20
        characterSelectView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
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
    
    @IBAction func touchStyleSelectButton(_ sender: Any) {
        putCharacterStyle(data: CharacterStyleReqeust(characterSkin: selectedSkinIndex + 64,
                                                      characterType: selectedCardId / 9 + 1,
                                                      characterCard: selectedCardId))
    }
    
}

// MARK: - UICollectionViewDelegate

extension CharacterStyleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        
        switch collectionView {
        case characterTypeCollectionView:
            let cellWidth = width * (52 / 375)
            let cellHeight = cellWidth * (52 / 52)
    
            return CGSize(width: cellWidth, height: cellHeight)
        case characterCardCollectionView:
            let cellWidth = width * (95 / 375)
            let cellHeight = cellWidth * (130 / 95)
            
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
        case characterTypeCollectionView:
            return UIEdgeInsets(top: 14, left: 24, bottom: 0, right: 24)
        case characterCardCollectionView:
            return UIEdgeInsets(top: 32, left: 24, bottom: 16, right: 24)
        case backgroundCollectionView:
            return UIEdgeInsets(top: 14, left: 0, bottom: 24, right: 0)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case characterTypeCollectionView:
            return 26
        case characterCardCollectionView:
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
        case characterCardCollectionView:
            return characterData.characters[selectedTypeIndex].cards[indexPath.row].hasCard
        case backgroundCollectionView:
            return characterData.skins[indexPath.row].hasSkin
        default:
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case characterTypeCollectionView:
            selectedTypeIndex = indexPath.row
            if characterData.characters[indexPath.row].cards[0].hasCard {
                emptyViewLabel.isHidden = true
                characterCardCollectionView.isHidden = false
            } else {
                emptyViewLabel.isHidden = false
                characterCardCollectionView.isHidden = true
            }
            characterTypeCollectionView.reloadData()
            characterCardCollectionView.reloadData()
        case characterCardCollectionView:
            allCardSelectedInfo = Array(repeating: Array(repeating: false, count: 9), count: 7)
            selectedCardIndex = indexPath.row
            selectedCardId = selectedTypeIndex * 9 + selectedCardIndex + 1
            characterImageView.updateServerImage(characterData.characters[selectedTypeIndex].cards[indexPath.row].image)
            allCardSelectedInfo[selectedTypeIndex][selectedCardIndex] = true
            characterCardCollectionView.reloadData()
        case backgroundCollectionView:
            selectedSkinIndex = indexPath.row
            backgroundSelectButton.setImage(backgroundSkins[indexPath.row].getOwnedSkinIcn(), for: .normal)
            backgroundImageView.updateServerImage(characterData.skins[indexPath.row].image)
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
        case characterTypeCollectionView:
            return characterData.characters.count
        case characterCardCollectionView:
            return characterData.characters[selectedTypeIndex].cards.count
        case backgroundCollectionView:
            return characterData.skins.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case characterTypeCollectionView:
            guard let cell = characterTypeCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.characterTypeCollectionViewCell, for: indexPath) as? CharacterTypeCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.row == selectedTypeIndex {
                cell.showSelectView()
            } else {
                cell.hideSelectView()
            }
            
            if characterData.characters[indexPath.row].cards.count > 0
                && characterData.characters[indexPath.row].cards[0].hasCard {
                cell.setData(image: AppCharacter(rawValue: indexPath.row)!.getThumbnailCharacterImg())
            } else {
                cell.setData(image: AppCharacter(rawValue: indexPath.row)!.getThumbnailCharacterLockImg())
            }
            
            return cell
        case characterCardCollectionView:
            guard let cell = characterCardCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.characterColorCollectionViewCell, for: indexPath) as? CharacterColorCollectionViewCell else { return UICollectionViewCell() }
            
            indicateIsNewCard(cell, indexPath: indexPath)
            indicateOwnedCard(cell, indexPath: indexPath)
            markCellSeletedState(cell, indexPath: indexPath)
            
            return cell
        case backgroundCollectionView:
            guard let cell = backgroundCollectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.Identifier.backgroundCollectionViewCell, for: indexPath) as? BackgroundCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.row == selectedSkinIndex {
                cell.setData(image: backgroundSkins[indexPath.row].getSelectedSkinIcn())
            } else if characterData.skins[indexPath.row].hasSkin {
                cell.setData(image: backgroundSkins[indexPath.row].getOwnedSkinIcn())
            } else {
                cell.setData(image: backgroundSkins[indexPath.row].getLockSkinIcn())
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func indicateIsNewCard(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if characterData.characters[selectedTypeIndex].cards[indexPath.row].isNew {
            cell.showNewIndicator()
        } else {
            cell.hideNewIndicator()
        }
    }
    
    func indicateOwnedCard(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if characterData.characters[selectedTypeIndex].cards[indexPath.row].hasCard {
            cell.setUnlockCharacter(image: characterData.characters[selectedTypeIndex].cards[indexPath.row].image)
        } else {
            cell.setLockCharacter(typeId: characterData.characters[selectedTypeIndex].type - 1)
        }
    }
    
    func markCellSeletedState(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if allCardSelectedInfo[selectedTypeIndex][indexPath.row] {
            cell.showSelectedView()
            changeNewState(cell, indexPath: indexPath)
        } else {
            cell.showUnselectedView()
        }
    }
    
    func changeNewState(_ cell: CharacterColorCollectionViewCell, indexPath: IndexPath) {
        if characterData.characters[selectedTypeIndex].cards[indexPath.row].isNew {
            cell.hideNewIndicator()
            characterData.characters[selectedTypeIndex].cards[indexPath.row].isNew = false
        }
    }
    
}

extension CharacterStyleViewController {
    
    /*
     skin id가 64부터 시작하기 때문에 collectionView indexPath랑 맞추기 위해서 64 뺌
     card id가 탭별로 9배수이기 때문에 selectedCell Point를 2차원 배열로 관리하기 위해서 나누기, 나머지 연산 수행
     */
    func getUserCharacterInfo() {
        CharacterAPI.shared.getCharacterInfo { response in
            switch response {
            case .success(let data):
                if let data = data as? CharacterStyle {
                    self.characterData = data
                    self.characterImageView.updateServerImage(data.currentCharacter.image)
                    self.selectedSkinIndex = data.currentSkin.id - 64
                    self.selectedTypeIndex = data.currentCharacter.id / 9
                    self.selectedCardIndex = data.currentCharacter.id % 9
                    self.selectedCardId = data.currentCharacter.id
                    self.setCurrentCharacterCellSelect(typeIndex: self.selectedTypeIndex, cardIndex: self.selectedCardIndex)
                    self.backgroundImageView.updateServerImage(data.currentSkin.image)
                    self.backgroundSelectButton.setImage(BackgroundSkin(rawValue: data.currentSkin.id - 64)?.getOwnedSkinIcn(), for: .normal)
                    self.characterCardCollectionView.reloadData()
                    self.characterTypeCollectionView.reloadData()
                    self.backgroundCollectionView.reloadData()
                }
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    func putCharacterStyle(data: CharacterStyleReqeust) {
        CharacterAPI.shared.putCharacterStyle(data: data) { response in
            switch response {
            case .success(let data):
                self.showToast(message: "스타일이 변경되었습니다.", font: .spoqaHanSansNeo(size: 12))
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
}
