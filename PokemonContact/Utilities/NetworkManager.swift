//
//  NetworkManager.swift
//  PokemonContact
//
//  Created by 김승희 on 7/17/24.
//

import Foundation
import Alamofire

func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
    AF.request(url).responseDecodable(of: T.self) { response in
        completion(response.result)
    }
}
