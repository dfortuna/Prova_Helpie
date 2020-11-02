//
//  StorageService.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 31/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage


struct StorageService {

    private init() {}
    static let shared = StorageService()
    private let storageRef = Storage.storage().reference()
    
    func uploadImage(image: UIImage, toURL url: FIRCollectionReference,
                     callback: @escaping (Result<String, HError>) -> ()) {
        
        
        guard let imageData = image.pngData() else {
            callback(.failure(.uploadError))
            print("3333333")
            return
        }

        let imageDataRef = storageRef.child("\(url.path).png")

        imageDataRef.putData(imageData, metadata: nil) { (storageMetadata, error) in
            if error == nil {
        
                imageDataRef.downloadURL { (url, error) in
                    if let url = url {
                        callback(.success(url.absoluteString))
                    } else {
                        print("22222222")
                        callback(.failure(.uploadError))
                    }
                }
            } else {
                print("11111111")
                callback(.failure(.uploadError))
            }
        }
    }
    

}
