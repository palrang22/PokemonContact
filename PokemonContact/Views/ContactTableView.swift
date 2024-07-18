//
//  ContactTableView.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit
import SnapKit

class ContactTableView: UIView {
    
    var contacts: [PokemonContact] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    weak var delegate: ContactTableViewDelegate?
    
    private var tableView : UITableView = {
        let tableView = UITableView()
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
    
    private func readAllData() {
        self.contacts = CoreDataManager.shared.readData()
        self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        delegate?.didSelectContact(contact)
    }
}

extension ContactTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.configTableViewCell(contact)
        return cell
    }
}

protocol ContactTableViewDelegate: AnyObject {
    func didSelectContact(_ contact: PokemonContact)
}
