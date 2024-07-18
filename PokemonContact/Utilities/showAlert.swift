//
//  showAlert.swift
//  PokemonContact
//
//  Created by 김승희 on 7/18/24.
//

import UIKit

func showAlert(message: String, on viewController: UIViewController) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    viewController.present(alert, animated: true)
}
