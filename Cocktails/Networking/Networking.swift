//
//  Networking.swift
//  Cocktails
//
//  Created by Egor Korp on 11.09.22.
//

import Foundation

class Networking {
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void){
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        
    }
    func fetchData(urlString: String, completion: @escaping (Drink?) -> Void) {
        request(urlString: urlString) { data, error in
            guard let data = data else { return }
            let responce = try? JSONDecoder().decode(Drink.self, from: data)
            completion(responce)
        }
    }
}
