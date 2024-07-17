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
    
    private var profileImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.lightGray.cgColor
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
        fetchPokemonData()
    }
    
    private func fetchPokemonData() {
        let randomId = Int.random(in: 1...1025)
        let imgUrl = "https://pokeapi.co/api/v2/pokemon/\(randomId)"
        guard let url = URL(string: imgUrl) else {
            print("URL 오류")
            return
        }
        
        fetchData(url: url) { [weak self] (result: Result<PokemonModel, AFError>) in
            guard let self else { return }
            switch result {
            case .success(let pokemon):
                guard let imgUrl = URL(string: pokemon.sprites.frontDefault) else {
                    print("이미지 url 오류")
                    return
                }
                AF.request(imgUrl).responseData { response in
                    if let data = response.data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.profileImage.image = image
                        }
                    }
                }
            case .failure(let error):
                print("데이터 로딩 실패")
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
