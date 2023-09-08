//
//  SecondViewController.swift
//  DataBinding
//
//  Created by Chun-Li Cheng on 2021/12/7.
//

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {
    
    let myLabel: UILabel = {
        let l = UILabel()
        l.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .orange
        return l
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        myLabel.center = view.center
        
//        let name = Observer("Steve")
//        name.bind { value in
//            print(value ?? "")
//        }
//        name.value = "Mary"
//        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//            name.value = "Groot"
//        }
        
        let a /*: Observable<Int>*/ = BehaviorRelay(value: 1)   // a = 1
        let b /*: Observable<Int>*/ = BehaviorRelay(value: 2)   // b = 2

        // Combines latest values of relays `a` and `b` using `+`
        let c = Observable.combineLatest(a, b) { $0 + $1 }
            .filter { $0 >= 0 }               // if `a + b >= 0` is true, `a + b` is passed to the map operator
            .map { "\($0) is positive" }
        print(a)
        print(b)
        print(c)
        c.subscribe {
            print($0)
        }.disposed(by: disposeBag)
        a.accept(4)
        b.accept(-8)

    }
    
}
