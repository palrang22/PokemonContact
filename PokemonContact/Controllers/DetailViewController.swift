//
//  DetailViewController.swift
//  PokemonContact
//
//  Created by 김승희 on 7/15/24.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailViewController()
        setNavigationBar()
    }
    
    private func setDetailViewController() {
        view.backgroundColor = .white
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "연락처 추가"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc private func doneButtonTapped() {
        
    }
}
