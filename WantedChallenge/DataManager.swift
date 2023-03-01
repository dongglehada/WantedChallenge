//
//  DataManager.swift
//  WantedChallenge
//
//  Created by SeoJunYoung on 2023/02/17.
//

import UIKit

class DataManager {
    
    var urlArray: [UrlData] = []
    
    func makeUrlArray(){
        urlArray = [
            UrlData(url: URL(string: "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg?auto=compress&cs=tinysrgb&w=800")),
            UrlData(url: URL(string: "https://images.pexels.com/photos/1525041/pexels-photo-1525041.jpeg?auto=compress&cs=tinysrgb&w=800")),
            UrlData(url: URL(string: "https://images.pexels.com/photos/1379636/pexels-photo-1379636.jpeg?auto=compress&cs=tinysrgb&w=800")),
            UrlData(url: URL(string: "https://images.pexels.com/photos/3052361/pexels-photo-3052361.jpeg?auto=compress&cs=tinysrgb&w=800")),
            UrlData(url: URL(string: "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&w=800"))
        ]
    }
    
    func getUrlArray() -> [UrlData]{
        return urlArray
    }
    
    func delDataArray(){
        urlArray = []
        
    }
}
