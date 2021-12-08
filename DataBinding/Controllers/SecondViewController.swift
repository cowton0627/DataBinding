//
//  SecondViewController.swift
//  DataBinding
//
//  Created by Chun-Li Cheng on 2021/12/7.
//

import UIKit

class SecondViewController: UIViewController {
    
    let myLabel: UILabel = {
        let l = UILabel()
        l.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        myLabel.center = view.center
        
//        let name = Observable("Steve")
//        print(name.value ?? "")
//        name.value = "Tom"
//        print(name.value ?? "")
//        
//        name.bind { value in
//            print(value ?? "")
//        }
//        
//        name.value = "Mary"
//        name.value = "I'm Groot"
//        
//        name.bind {
//            self.myLabel.text = $0
//        }
//        
//        name.value = "Hey"
//        
//        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//            name.value = "Ha"
//        }
//        
//        let alive = Observable(false)
//        alive.bind {
//            print($0 ?? true)
//        }

    }
    
}
