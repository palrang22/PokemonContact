//
//  DetailViewController.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 100
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
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailViewController()
        setNavigationBar()
    }
    
    @objc private func doneButtonTapped() {
        print("donebuttontapped")
    }
    
    @objc private func randomButtonTapped() {
        print("randombuttontapped")
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
