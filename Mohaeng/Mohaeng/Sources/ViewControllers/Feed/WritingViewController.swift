//
//  WritingViewController.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/09/26.
//

import UIKit

import SnapKit
import Then

class WritingViewController: UIViewController {

// MARK: - Properties
    public var mood: Int? {
        didSet {
            guard let mood = mood else { return }
            moodImageView.image = moodImageArray[mood]
            writingRequest.mood = mood
        }
    }
    
    private lazy var hasNotch = UIDevice.current.hasNotch
    
    private var writingRequest = WritingRequest(content: "", mood: 0, isPrivate: false, image: nil)
    
    private let imagePicker = UIImagePickerController()
    
    private let moodImageArray = Const.Image.moodImageArray
    
    private let titleLabel = UILabel().then {
        $0.font = .gmarketFont(weight: .medium, size: 22)
        $0.textColor = .Black
        guard let nickname = UserDefaults.standard.string(forKey: "nickname") else { return }
        $0.text = "\(nickname)의 오늘을 남겨줘"
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = .spoqaHanSansNeo(weight: .regular, size: 13)
        $0.textColor = .Grey3
        $0.text = "챌린지와 함께한 하루 이야기를 기록으로 남겨봐"
    }
  
    private let writingCountLabel = UILabel().then {
        $0.font = .spoqaHanSansNeo(weight: .regular, size: 10)
    }
    
    private let yellowBackgroundView = UIView().then {
        $0.backgroundColor = .todayYellow
    }
    
    private let moodImageView = UIImageView()
    
    private let seperatorView = UIView().then {
        $0.backgroundColor = .Yellow4
    }
    
    private let textView = UITextView().then {
        $0.backgroundColor = .clear
        $0.font = .spoqaHanSansNeo(weight: .regular, size: UIDevice.current.hasNotch ? 14 : 12)
        $0.textColor = .Black
        $0.tintColor = .Yellow3
        $0.textContainer.maximumNumberOfLines = 5
    }
    
    private let addPhotoView = UIView().then {
        $0.backgroundColor = .YellowButton2
    }
    
    private let plusImageView = UIImageView().then {
        $0.image = Const.Image.plusPhotoImage
    }
    
    private let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    private let addPhotoLabel = UILabel().then {
        $0.text = "하루를 사진으로 남겨봐!"
        $0.textColor = .Grey1
        $0.font = .spoqaHanSansNeo()
    }
    
    private let checkBoxButton = UIButton().then {
        $0.setImage(Const.Image.checkBoxLineImage, for: .normal)
        $0.setImage(Const.Image.checkBoxImage, for: .selected)
        $0.setTitle("피드에 오늘의 안부를 공유할게!", for: .normal)
        $0.setTitleColor(.Black, for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo()
        $0.isSelected = true
        $0.adjustsImageWhenHighlighted = false
        $0.alignTextLeft()
    }
    
    private let photoImageView = UIImageView().then {
        $0.isHidden = true
        $0.makeRounded(radius: 4.0)
        $0.isUserInteractionEnabled = true
    }
    
    private let removePhotoButton = UIButton().then {
        $0.setImage(Const.Image.photoXbtnImage, for: .normal)
    }
    
    private let doneButton = UIButton(type: .system).then {
        $0.setTitle("작성완료", for: .normal)
        $0.titleLabel?.font = .spoqaHanSansNeo(weight: .bold, size: 16)
        $0.setTitleColor(.White, for: .normal)
        $0.setBackgroundColor(.YellowButton1, for: .normal)
        $0.setBackgroundColor(.GreyButton1, for: .disabled)
        $0.isEnabled = false
    }
    
// MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initViewContoller()
        
        setLayout()
        setTarget()
        setGesture()
        setTextView()
        setImagePicker()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeRoundedViews()
    }
    
// MARK: - Functions
    private func makeRoundedViews() {
        yellowBackgroundView.makeRounded(radius: 20)
        doneButton.makeRoundedSpecificCorner(corners: [.topLeft, .topRight], cornerRadius: 30.0)
    }
    
    private func initViewContoller() {
        view.backgroundColor = .White
        writingCountLabel.attributedText = setAttributedCustomText(text: "\(String(textView.text?.count ?? 0)) / 40자")
    }
    
    private func initNavigationBar() {
        navigationController?.initWithBackAndCloseButton(navigationItem: self.navigationItem, closeButtonClosure: #selector(buttonDidTapped(_:)))
        let currentDate = AppDate()
        let currentMonth = currentDate.getMonth()
        let currentDay = currentDate.getDay()
        navigationItem.title = "\(currentMonth)월 \(currentDay)일"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.spoqaHanSansNeo(weight: .regular, size: 14), NSAttributedString.Key.foregroundColor: UIColor.Black]
    }
    
    private func setLayout() {
        setViewHierachy()
        setConstraints()
    }
    
    private func setTextView() {
        setPlaceholder()
        textView.delegate = self
    }
    
    private func setPlaceholder() {
        textView.text = "챌린지와 함께한 하루 이야기를 기록으로 남겨봐"
        textView.textColor = .Grey4
    }
    
    private func setTarget() {
        [checkBoxButton, removePhotoButton, doneButton].forEach {
            $0.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func setGesture() {
        let addPhotoTapGesture = UITapGestureRecognizer(target: self, action: #selector(addPhoto(sender:)))
        addPhotoView.addGestureRecognizer(addPhotoTapGesture)
        
        let addPhotoTapGesture2 = UITapGestureRecognizer(target: self, action: #selector(addPhoto(sender:)))
        photoImageView.addGestureRecognizer(addPhotoTapGesture2)
    }
    
    private func setImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    private func showActionSheet() -> UIAlertController {
        let alert = UIAlertController(title: "사진 업로드", message: nil, preferredStyle: .actionSheet)

        let library = UIAlertAction(title: "앨범에서 사진 선택", style: .default) { [weak self] _ in
            self?.openLibrary()
        }

        let camera = UIAlertAction(title: "사진 찍기", style: .default) { [weak self] _ in
            self?.openCamera()
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)

        return alert
    }

    private func openLibrary() {
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true)
    }

    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true)
        } else {
            print("Camera not available")
        }
    }
    
    private func removePhoto() {
        writingRequest.image = nil
        addPhotoView.isHidden = false
        photoImageView.isHidden = true
        yellowBackgroundView.snp.updateConstraints {
            $0.height.equalTo(hasNotch ? 356 : 314)
        }
    }
    
}

// MARK: - @objc Functions

extension WritingViewController {
    @objc
    private func buttonDidTapped(_ sender: UIButton) {
        switch sender {
        case navigationItem.rightBarButtonItem:
            dismiss(animated: true, completion: nil)
        case checkBoxButton:
            checkBoxButton.isSelected.toggle()
            writingRequest.isPrivate = !checkBoxButton.isSelected
        case removePhotoButton:
            removePhoto()
        case doneButton:
            postFeedWriting {[weak self] response in
                NotificationCenter.default.post(name: NSNotification.Name("RefreshFeedCollectionView"),
                                                object: nil,
                                                userInfo: nil)
                let writingRewardViewController = WritingRewardViewController()
                writingRewardViewController.writingResponse = response
                self?.navigationController?.pushViewController(writingRewardViewController, animated: true)
            }
           
        default:
            break
        }
    }
    
    @objc func addPhoto(sender: UITapGestureRecognizer) {
        present(showActionSheet(), animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension WritingViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let originalImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
        let editedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as? UIImage
        let selectedImage = editedImage ?? originalImage
        
        photoImageView.image = selectedImage
        writingRequest.image = selectedImage
        imagePicker.dismiss(animated: true) {[weak self] in
            guard let self = self else {return}
            self.addPhotoView.isHidden = true
            self.yellowBackgroundView.snp.updateConstraints {
                $0.height.equalTo(self.hasNotch ? 424 : 360)
            }
            self.photoImageView.isHidden = false
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension WritingViewController: UINavigationControllerDelegate {}

// MARK: - UITextViewDelegate

extension WritingViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .Grey4 {
            textView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceholder()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        doneButton.isEnabled = textView.text.count > 0
        
        textView.attributedText = setAttributedText(text: textView.text)
        writingCountLabel.attributedText = setAttributedCustomText(text: "\(String(textView.text?.count ?? 0)) / 40자")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newLength = textView.text.count + text.count - range.length
        return newLength <= 40
    }
    
    func setAttributedCustomText(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.Yellow3, range: (text as NSString).range(of: "/ 40자"))
        return attributeString
    }
    
    func setAttributedText(text: String) -> NSAttributedString {

        let attributeString = NSMutableAttributedString(string: text)

        let font: UIFont = .spoqaHanSansNeo(weight: .regular, size: hasNotch ? 14 : 12)
        let lineSpacing: CGFloat = hasNotch ? 10 : 8
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: text))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: (text as NSString).range(of: text))
        
        return attributeString
    }
    
}

extension WritingViewController {
    func postFeedWriting(completion: @escaping(WritingResponse) -> Void) {
        writingRequest.content = textView.text
        FeedAPI.shared.postFeed(writingRequest: writingRequest) { (response) in
            switch response {
            case .success(let data):
                if let data = data as? WritingResponse {
                    completion(data)
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
}

// MARK: - Layouts

extension WritingViewController {
    private func setViewHierachy() {
        view.addSubviews(titleLabel, subTitleLabel, yellowBackgroundView, checkBoxButton, doneButton)
        
        yellowBackgroundView.addSubviews(writingCountLabel, moodImageView, seperatorView, textView, addPhotoView, photoImageView)
        
        addPhotoView.addSubviews(hStackView)
        hStackView.addArrangedSubview(plusImageView)
        hStackView.addArrangedSubview(addPhotoLabel)
        
        photoImageView.addSubview(removePhotoButton)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(hasNotch ? 38 : 32)
            $0.leading.trailing.equalToSuperview().inset(hasNotch ? 24 : 16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(hasNotch ? 20 : 16)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        yellowBackgroundView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(hasNotch ? 40 : 32)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(hasNotch ? 356 : 314)
        }
        
        moodImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(hasNotch ? 28 : 20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(hasNotch ? 110 : 100)
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(hasNotch ? 166 : 140)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(seperatorView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(70)
        }
        
        writingCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(textView.snp.trailing)
            $0.bottom.equalTo(textView.snp.bottom)
        }
        
        addPhotoView.snp.makeConstraints {
            $0.height.equalTo(hasNotch ? 72 : 64)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        hStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        checkBoxButton.snp.makeConstraints {
            $0.top.equalTo(yellowBackgroundView.snp.bottom).offset(hasNotch ? 20 : 16)
            $0.leading.trailing.equalTo(titleLabel)
            $0.height.equalTo(24)
        }
        
        photoImageView.snp.makeConstraints {
            $0.width.height.equalTo(hasNotch ? 120 : 90)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        removePhotoButton.snp.makeConstraints {
            $0.width.height.equalTo(hasNotch ? 32 : 24)
            $0.trailing.top.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(hasNotch ? 76 : 56)
        }
    }
}
