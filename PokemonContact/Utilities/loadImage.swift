//
//  loadImage.swift
//  PokemonContact
//
//  Created by 김승희 on 7/18/24.
//

import UIKit
import Alamofire

func loadImage(from url: String, into imageView: UIImageView) {
    guard let url = URL(string: url) else {
        print("잘못된 URL")
        return
    }
    
    AF.request(url).responseData { response in
        switch response.result {
        case .success(let data):
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } else {
                print("이미지 변환 실패")
            }
        case .failure(let error):
            print("url:", url)
            print("이미지 로드 실패: \(error.localizedDescription)")
        }
    }
}
