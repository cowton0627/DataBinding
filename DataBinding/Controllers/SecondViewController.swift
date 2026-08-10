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
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .orange
        return label
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
        
//        let a /*: Observable<Int>*/ = BehaviorRelay(value: 1)   // a = 1
//        let b /*: Observable<Int>*/ = BehaviorRelay(value: 2)   // b = 2
//
//        // Combines latest values of relays `a` and `b` using `+`
//        let c = Observable.combineLatest(a, b) { $0 + $1 }
//            .filter { $0 >= 0 }               // if `a + b >= 0` is true, `a + b` is passed to the map operator
//            .map { "\($0) is positive" }
//        c.subscribe {
//            print($0)
//        }.disposed(by: disposeBag)
//        a.accept(4)
//        b.accept(-8)
        
        let subject = ReplaySubject<String>.create(bufferSize: 3)

        subject.onNext("15")
        // 1, 2
        subject
            .debug("A")
            .subscribe()
            .disposed(by: disposeBag)

        subject.onNext("23")

        subject.onNext("33")

        subject
            .debug("B")
            .subscribe()
            .disposed(by: disposeBag)
        // 3
        subject.onError(NSError(domain: "Test", code: -1, userInfo: nil))

    }
    
}
