//
//  ContactTableView.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit
import SnapKit

class ContactTableView: UIView {
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ContactTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ContactTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
