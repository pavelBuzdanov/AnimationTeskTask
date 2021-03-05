//
//  NetworkManager.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit



class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let urlString = "https://api.unsplash.com/photos/random/?count=30&client_id=1A113v0MjXaUNHlD7l5wSp5u88lW0eJhuqIoWPGHTxk"
    
    private let urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
          return decoder
      }()
    
    //MARK: - Private init
    private init() {}
    
    
    //MARK: - Public
    func fetchImageData(_ completion: @escaping (Result<[PhotoModel], Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        
        fetchData(request: request) { (result: Result<[PhotoModel], Error>) in
            switch result {
            
            case.success(let data):  completion( .success(data) )
                
                
            case.failure(let error):  completion( .failure(error) )
            
            }
        }
    }
    
    //MARK: - Private
    private  func fetchData<D: Decodable>(request: URLRequest, completion: @escaping(Result<D, Error>) -> ()) {
        let urlRequest = request
        
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
                completion(.failure(error))
                return
            }
            
            do {
                let d = try self.jsonDecoder.decode(D.self, from: data)
                completion(.success(d))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
}
