//
//  ViewController.swift
//  RxSwift_App
//
//  Created by Eyad Heikal on 4/28/20.
//  Copyright © 2020 Eyad Heikal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var disposeBag = DisposeBag()
    var moviesArray: Variable<[Any]> = Variable([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        let str = "https://api.themoviedb.org/3/movie/top_rated?api_key=9a0a83633bee84f184e6f6d3b1edc7bd&language=en-US&page=1"
        let url = URL(string: str)
        let urlRequest = URLRequest(url: url!)
        URLSession.shared.rx.json(request: urlRequest)
            .map{
                let results = $0 as AnyObject
                let items = results.object(forKey: "results") as? [Dictionary<String, Any>] ?? []
                
                for item in items {
                    guard let title = item["title"] as? String else { return }
                    self.moviesArray.value.append(title)
                }
            }
            .observeOn(MainScheduler.instance)
            .asObservable()
            .subscribe(onNext:{
                
                self.moviesArray.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: "myCell")){row, element, cell in
                    print(element)
                    //cell.textLabel = self.moviesArray.value[row]
                    cell.textLabel?.text = self.moviesArray.value[row] as? String
                }.disposed(by: self.disposeBag)

            })
            .disposed(by: disposeBag)
        

        
    }


}
