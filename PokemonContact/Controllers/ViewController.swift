//
//  ViewController.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(primaryAction: UIAction(handler: { _ in
            self.navigationController?.pushViewController(DetailViewController(), animated: true)
        }))
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let contactTableView = ContactTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainPage()
    }
    
    private func setupMainPage() {
        view.backgroundColor = .white
        [pageLabel, addButton, contactTableView].forEach{ self.view.addSubview($0) }
        pageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
        addButton.snp.makeConstraints {
            $0.centerY.equalTo(pageLabel)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        contactTableView.snp.makeConstraints {
            $0.top.equalTo(pageLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
