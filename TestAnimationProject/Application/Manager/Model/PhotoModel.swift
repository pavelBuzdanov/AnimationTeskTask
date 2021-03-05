//
//  PhotoModel.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit

struct PhotoModel: Codable {
    
    let width: Int
    let height: Int
    let urls: Urls
    
    
}

struct Urls: Codable {
    let small: String?
}
