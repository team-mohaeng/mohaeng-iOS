//
//  WritingViewController.swift
//  Journey
//
//  Created by 윤예지 on 2021/07/07.
//

import UIKit

class WritingViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var writingTextView: UITextView!
    @IBOutlet weak var hashTagTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var photoUploadImageView: UIImageView!
    @IBOutlet weak var photoRemoveButton: UIButton!
    @IBOutlet weak var hashTagCollectionView: UICollectionView!
    @IBOutlet weak var writingCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    
    var hashTagList: [String] = []
    var sendHashTagList: [String] = [] // 서버 전송용
    var hashTagPopUp: PopUpViewController = PopUpViewController()
    var donePopUp: HappyPopUpViewController = HappyPopUpViewController()
    var moodStatus: Int = 0
    var doneStatus: Bool = false
    var hasImage: Bool = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initNavigationBar()
        initCurruentDay()
        registerXib()
        setDelegation()
        setTextViewDelegation()
        setTextFieldDelegation()
        initAttriutes()
        addGestureRecognizer()
        addObserver()
    }
    
    // MARK: - function
    
    private func initNavigationBar() {
        self.navigationController?.initWithBackButton()
    }
    
    private func initCurruentDay() {
        let currentDay = AppDate()
        dateLabel.text = "\(currentDay.getFormattedDate(with: ".")) (\(currentDay.getWeekday()))"
    }
    
    private func registerXib() {
        let hashTagCollectionViewCell = UINib(nibName: "HashTagCollectionViewCell", bundle: nil)
        hashTagCollectionView.register(hashTagCollectionViewCell, forCellWithReuseIdentifier: "HashTagCollectionViewCell")
    }
    
    private func setDelegation() {
        hashTagCollectionView.dataSource = self
        hashTagCollectionView.delegate = self
    }
    
    private func setTextViewDelegation() {
        writingTextView.delegate = self
    }
    
    private func setTextFieldDelegation() {
        hashTagTextField.delegate = self
    }
    
    private func initAttriutes() {
        writingTextView.layer.borderWidth = 0.5
        writingTextView.layer.borderColor = UIColor.textViewBorderColor.cgColor
        writingTextView.makeRounded(radius: 10)
        
        doneButton.makeRounded(radius: doneButton.frame.height / 2)
        
        photoUploadImageView.makeRounded(radius: 4)
        
        writingTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        hashTagTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: hashTagTextField.frame.height))
        hashTagTextField.leftViewMode = .always
    }
    
    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchPhotoUploadView(_:)))
        photoUploadImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func touchPhotoUploadView(_ gesture: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 0, height: 0)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: font], context: nil)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(touchHashTagRemoveButton), name: NSNotification.Name("hashTagRemoveButtonClicked"), object: nil)
    }
    
    @objc func touchHashTagRemoveButton(notification: NSNotification) {
        if let index = notification.object as? Int {
            hashTagList.remove(at: index)
            hashTagCollectionView.reloadData()
        }
    }
    // MARK: - @IBAction
    
    @IBAction func touchPhotoRemoveButton(_ sender: Any) {
        photoUploadImageView.image = Const.Image.imgPhotoUpload
        hasImage = false
        photoRemoveButton.isHidden = true
    }
    
    @IBAction func touchDoneButton(_ sender: Any) {
        doneStatus = true
        
        donePopUp = HappyPopUpViewController(nibName: Const.Xib.Name.happyPopUp, bundle: nil)
        donePopUp.modalPresentationStyle = .overCurrentContext
        donePopUp.modalTransitionStyle = .crossDissolve
        donePopUp.delegate = self
        tabBarController?.present(donePopUp, animated: true, completion: nil)
        
        if hasImage {
            donePopUp.hasImage = true
            donePopUp.image = photoUploadImageView.image
        } else {
            donePopUp.hasImage = false
        }
        
        donePopUp.titleLabel.text = "소확행 작성 완료!"
        donePopUp.descriptionLabel.text = "당신의 행복이 하나 더 늘었군.\n다른 쟈기들과 함께하면 기쁨이 배가 될거야.\n함께 행복을 공유해보겠어?"
        donePopUp.shareButton?.setTitle("피드에 공유하기", for: .normal)
        donePopUp.saveButton?.setTitle("내 서랍장에만 저장하기", for: .normal)
    }
    
}

// 갤러리에서 이미지 가져오기
extension WritingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            photoUploadImageView.image = image
        }
        
        photoRemoveButton.isHidden = false
        hasImage = true
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension WritingViewController: UITextViewDelegate {
    
    // 텍스트뷰 PlaceHolder 생성
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if let text = writingTextView.text {
            if text == "오늘의 소확행을 작성해 주세요." {
                writingTextView.text = ""
            }
        }
        writingTextView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if writingTextView.text.count == 0 {
            writingTextView.textColor = .placeHolderColor
            writingTextView.text = "오늘의 소확행을 작성해 주세요."
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 텍스트뷰 글자수 0개 일 때 버튼 비활성화
        if writingTextView.text.count > 0 {
            doneButton.isEnabled = true
            doneButton.alpha = 1.0
        } else {
            doneButton.isEnabled = false
            doneButton.alpha = 0.4
        }
        
        // 텍스트뷰 글자수 카운트
        writingCountLabel.text = String(writingTextView.text?.count ?? 0)
    }
    
    // 텍스트뷰 글자수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLenth = textView.text.count + text.count - range.length
        return newLenth <= 40
    }
    
}

extension WritingViewController: UITextFieldDelegate {
    
    // 텍스트필드 글자수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let newLength = text.count + string.count - range.length
            return newLength <= 6
        }
        return false
    }
    
    // 키보드에서 return 선택 시 해시태그 추가, 5개 초과 시 팝업
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == hashTagTextField {
            if hashTagList.count < 5 {
                hashTagList.append("\(textField.text!)")
                sendHashTagList.append("#\(textField.text!)")
                textField.text = ""
                hashTagCollectionView.reloadData()
            } else {
                hashTagPopUp = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
                hashTagPopUp.modalPresentationStyle = .overCurrentContext
                hashTagPopUp.modalTransitionStyle = .crossDissolve
                hashTagPopUp.popUpUsage = .noTitle
                hashTagPopUp.popUpActionDelegate = self
                tabBarController?.present(hashTagPopUp, animated: true, completion: nil)
                
                hashTagPopUp.pinkButton?.setTitle("확인", for: .normal)
                hashTagPopUp.descriptionLabel?.text = "태그는 최대 5개까지\n 입력할 수 있어요!"
            }
        }
        return true
    }
    
    // 띄어쓰기 입력 들어올 때 띄어쓰기 삭제
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 && textField.text?.last == " " {
            textField.text?.removeLast()
        }
    }
}

// 해시태그 컬렉션뷰
extension WritingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.estimatedFrame(text: hashTagList[indexPath.row], font: UIFont.systemFont(ofSize: 12)).width
        
        return CGSize(width: width, height: 27)
    }
    
}

extension WritingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashTagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = hashTagCollectionView.dequeueReusableCell(withReuseIdentifier: "HashTagCollectionViewCell", for: indexPath) as? HashTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(keyword: hashTagList[indexPath.row])
        cell.makeRounded(radius: cell.frame.height / 2)
        
        return cell
    }
    
}

extension WritingViewController: PopUpActionDelegate {
    
    func touchPinkButton(button: UIButton) {
        if !doneStatus {
            self.hashTagPopUp.dismiss(animated: true, completion: nil)
        } else {
            if hasImage {
                postFeed(mood: moodStatus, content: writingTextView.text, hashtags: sendHashTagList, mainImage: photoUploadImageView!.image!, isPrivate: false)
            } else {
                postFeedWithoutImage(mood: moodStatus, content: writingTextView.text, hashtags: sendHashTagList, isPrivate: false)
            }
            self.donePopUp.dismiss(animated: true, completion: nil)
            let feedStoryboard = UIStoryboard(name: Const.Storyboard.Name.feed, bundle: nil)
            guard let feedViewController = feedStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.feed) as? FeedViewController else { return }
            self.navigationController?.pushViewController(feedViewController, animated: true)
        }
    }
    
    func touchWhiteButton(button: UIButton) {
        if hasImage {
            postFeed(mood: moodStatus, content: writingTextView.text, hashtags: sendHashTagList, mainImage: photoUploadImageView!.image!, isPrivate: true)
        } else {
            postFeedWithoutImage(mood: moodStatus, content: writingTextView.text, hashtags: sendHashTagList, isPrivate: true)
        }
        let myDrawerStoryboard = UIStoryboard(name: Const.Storyboard.Name.myDrawer, bundle: nil)
        guard let myDrawerViewController = myDrawerStoryboard.instantiateViewController(identifier: Const.ViewController.Identifier.myDrawer) as? MyDrawerViewController else { return }
        self.navigationController?.pushViewController(myDrawerViewController, animated: true)
    }
    
}

extension WritingViewController {
    
    func postFeed(mood: Int, content: String, hashtags: [String], mainImage: UIImage, isPrivate: Bool) {
        FeedAPI.shared.postFeed(mood: mood, content: content, hashtags: hashtags, mainImage: mainImage, isPrivate: isPrivate) { (response) in
            switch response {
            case .success(_):
                break
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
    
    func postFeedWithoutImage(mood: Int, content: String, hashtags: [String], isPrivate: Bool) {
        FeedAPI.shared.postFeedWithoutImage(mood: mood, content: content, hashtags: hashtags, isPrivate: isPrivate) { (response) in
            switch response {
            case .success(_):
                break
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
