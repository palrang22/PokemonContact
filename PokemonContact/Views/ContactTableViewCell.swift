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
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.text = "리자몽"
        return label
    }()
    
    private let phoneNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.text = "010-1111-2222"
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        setupTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configTableViewCell(_ contact: PokemonContact) {
        nameLabel.text = contact.name
        phoneNumLabel.text = contact.num
        guard let imgURL = contact.img else { return }
        loadImage(from: imgURL, into: profileImageView)
    }
    
    func setupTableViewCell() {
        [profileImageView, nameLabel, phoneNumLabel].forEach{ addSubview($0) }
        profileImageView.snp.makeConstraints {
            $0.height.width.equalTo(60)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImageView.snp.trailing).offset(40)
        }
        phoneNumLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
