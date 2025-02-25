//
//  DetailViewController.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit
import SnapKit
import Alamofire

class DetailViewController: UIViewController {
    
    enum Mode {
        case add
        case update(PokemonContact)
    }
    
    private var mode: Mode
    private var imgUrl: String?
    
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.lightGray.cgColor
        image.layer.cornerRadius = 100
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("랜덤 이미지 생성", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "이름"
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    private let contactField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "전화번호"
        textfield.borderStyle = .roundedRect
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailViewController()
        setNavigationBar()
        textfieldDelegate()
        
        switch mode {
        case .add:
            self.navigationItem.title = "연락처 추가"
        case .update(let contact):
            self.navigationItem.title = contact.name
            nameField.text = contact.name
            contactField.text = contact.num
            if let imgString = contact.img {
                self.imgUrl = imgString
                loadImage(from: imgString, into: profileImage)
            }
        }
    }
    
    @objc private func doneButtonTapped() {
        print("donebuttontapped")
        savePokemonData()
    }
    
    @objc private func randomButtonTapped() {
        print("randombuttontapped")
        fetchPokemonData()
    }
    
    private func savePokemonData() {
        guard let phoneNumber = contactField.text, !phoneNumber.isEmpty, phoneNumber != contactField.placeholder else {
            showAlert(message: "전화번호를 입력하세요!", on: self)
            return
        }
        let name = (nameField.text?.isEmpty ?? true) ? nameField.placeholder : nameField.text
        guard let imageURL = self.imgUrl else {
            showAlert(message: "랜덤 이미지 생성 버튼을 눌러 프로필사진을 넣어보세요!", on: self)
            return
        }
        
        switch mode {
        case .add:
            CoreDataManager.shared.createData(name: name!, num: phoneNumber, img: imageURL)
        case .update(let contact):
            CoreDataManager.shared.updateData(id: contact.id!, currentName: contact.name ?? "", updateName: name!, updateNum: phoneNumber, updateImg: imageURL)
        }
        self.navigationController?.popViewController(animated: true)
    }

    private func fetchPokemonData() {
        let randomId = Int.random(in: 1...1025)
        let apiUrl = "https://pokeapi.co/api/v2/pokemon/\(randomId)"
        guard let url = URL(string: apiUrl) else {
            print("URL 오류 1")
            return
        }
        fetchData(url: url) { [weak self] (result: Result<PokemonModel, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let pokemon):
                self.imgUrl = pokemon.sprites.frontDefault
                loadImage(from: self.imgUrl ?? "", into: self.profileImage)
                self.nameField.placeholder = pokemon.name
            case .failure(let error):
                print("데이터 로딩 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func setDetailViewController() {
        view.backgroundColor = .white
        [profileImage, randomButton, nameField, contactField].forEach{ view.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.height.width.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        randomButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImage.snp.bottom).offset(40)
        }
        nameField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(randomButton.snp.bottom).offset(40)
            $0.trailing.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        contactField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameField.snp.bottom).offset(20)
            $0.trailing.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(doneButtonTapped))
    }

}


extension DetailViewController: UITextFieldDelegate {
    func textfieldDelegate() {
        nameField.delegate = self
        contactField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == contactField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
