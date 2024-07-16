//
//  ContactTableViewCell.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit
import SnapKit

class ContactTableViewCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = 20
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let phoneNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableViewCell() {
        [profileImageView, nameLabel, phoneNumLabel].forEach{ addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(phoneNumLabel.snp.leading).offset(-20)
        }
        phoneNumLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
