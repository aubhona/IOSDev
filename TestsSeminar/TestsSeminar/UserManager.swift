//
//  UserManager.swift
//  TestsSeminar
//
//  Created by Aubkhon Abdullaev on 01.03.2024.
//

import Foundation
import UIKit

final class UserManager {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func downloadUserImage(completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: user.link) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid response")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Error: No data")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
}
