//
//  ImageLoader.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 05.03.2021.
//

import UIKit

class ImageLoader {
    
    //MARK: - Sahared
    static let shared = ImageLoader()
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    //MARK: - Private Init 
    private init() {}
    
    //MARK: - Load Image
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) {

      if let image = loadedImages[url] {
        completion(.success(image))
        return
      }

      let uuid = UUID()

      let task = URLSession.shared.dataTask(with: url) { data, response, error in
     
        defer {
            self.runningRequests.removeValue(forKey: uuid)
        }

        
        if let data = data, let image = UIImage(data: data) {
          self.loadedImages[url] = image
          completion(.success(image))
          return
        }

        guard let error = error else { return }

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }
        
      }
        
      task.resume()
      runningRequests[uuid] = task

    }

    
}
