//
//  ImageLoader.swift
//  WeatherTheStorm
//
//  Created by Nathan Hughes on 5/20/22.
//
// ImageLoader code tutorial found at:
// https://www.donnywals.com/efficiently-loading-images-in-table-views-and-collection-views/

import Foundation
import UIKit

class ImageLoader {
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

      if let image = loadedImages[url] {
        completion(.success(image))
          
        return nil
      }

      let uuid = UUID()
        
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
   
        defer { self.runningRequests.removeValue(forKey: uuid) }

        if let data = data, let image = UIImage(data: data) {
          self.loadedImages[url] = image
          completion(.success(image))
            
          return
        }

        guard let error = error else {

          return
        }

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
            
          return
        }

      }
      task.resume()
      runningRequests[uuid] = task
        
      return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
    
}
