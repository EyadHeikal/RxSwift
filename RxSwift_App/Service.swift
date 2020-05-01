//
//  Service.swift
//  RxSwift_App
//
//  Created by Eyad Heikal on 4/29/20.
//  Copyright © 2020 Eyad Heikal. All rights reserved.
//

import Foundation
import RxCocoa

class Service {
    static let shared = Service()
    
    private init() {
        
    }
    
    func getMovies() {
        let str = "https://api.themoviedb.org/3/movie/top_rated?api_key=9a0a83633bee84f184e6f6d3b1edc7bd&language=en-US&page=1"
        let url = URL(string: str)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!){ data,response, error in
            let x = try? JSONSerialization.jsonObject(with: data ?? Data())
            print(x ?? "")
        }
        dataTask.resume()
    }
    
    func getMoviesRX() {
        let str = "https://api.themoviedb.org/3/movie/top_rated?api_key=9a0a83633bee84f184e6f6d3b1edc7bd&language=en-US&page=1"
        let url = URL(string: str)
        URLSession.shared.rx.json(request: URLRequest(url: url!)).map{
            print($0)
        }
    }
}
