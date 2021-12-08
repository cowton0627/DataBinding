//
//  ThirdViewController.swift
//  DataBinding
//
//  Created by Chun-Li Cheng on 2021/12/8.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController {
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        
//        let name = Observer(String())
//        name.value = "Tom"
        
//        let name = Observer("Tom")
//        print(name.value ?? "")
//        name.value = "Kim"
//        print(name.value ?? "")
        
//        name.bind { value in
//            print(name.value ?? "")
//        }
//        name.value = "Kim"
//        print(name.value ?? "")
//        name.bind { value in
//            print("YO \(name.value ?? "")")
//        }
//        name.value = "Tom"
        
//        let middleName = Observer("Tom")
//        middleName.bind { value in
//            print(name.value ?? "")
//        }
//        middleName.value = "Cruise"
    }
    
    @IBAction func judgeBtnState() {
        // MARK: -方法零
        let observable = Observable.of([firstTextField, secondTextField, thirdTextField])
        observable.bind { textFields in
            
            let judgeFields = textFields.filter { $0?.text != "" }
            self.loginButton.isEnabled = (judgeFields.count == 3)
        }.disposed(by: disposeBag)
        
        
        // MARK: -方法一
//        if firstTextField.text != "" && secondTextField.text != "" && thirdTextField.text != "" {
//            loginButton.isEnabled = true
//        } else {
//            loginButton.isEnabled = false
//        }
        
        // MARK: -方法二
//          let bool = Observer(firstTextField.text != "" && secondTextField.text != "" && thirdTextField.text != "")
//          bool.bind { bool in
//              if let bool = bool {
////                  if bool {
////                      self.loginButton.isEnabled = true
////                  } else {
////                      self.loginButton.isEnabled = false
////                  }
//                  self.loginButton.isEnabled = bool
//              }
//          }
        
//        // MARK: -方法三
//        var txtFields = [UITextField]()
//        txtFields.append(contentsOf: [firstTextField, secondTextField, thirdTextField])
////        txtFields.append(firstTextField)
////        txtFields.append(secondTextField)
////        txtFields.append(thirdTextField)
//        let texx = Observer(txtFields)
//        texx.bind { texx in
////            texx?.forEach {
////                if $0.text != "" {
////                    self.loginButton.isEnabled = true
////                } else {
////                    self.loginButton.isEnabled = false
////                }
////            }
//            let texxx = texx?.filter { $0.text != "" }
//            self.loginButton.isEnabled = (texxx?.count == 3)
//        }
        
        // 最初的思考
//        let text1 = Observer(firstTextField)
//        let text2 = Observer(secondTextField)
//        let text3 = Observer(thirdTextField)
//        text1.bind { value in
//            if value != "" {
//                self.loginButton.isEnabled = true
//            } else {
//                self.loginButton.isEnabled = false
//            }
//        }
        
        // 這個判斷方式不對, 如果第一個欄位字元數大於 3就會開放點選
//        let text = Observer(firstTextField.text! + secondTextField.text! + thirdTextField.text!)
//        text.bind { value in
//            if let value = value {
//                if value.count >= 3 {
//                    self.loginButton.isEnabled = true
//                } else {
//                    self.loginButton.isEnabled = false
//                }
//            }
//        }
        
    }

}

// 另外寫的重複的Observer Pattern的Class
class Observer<T> {
    typealias listener = (T?) -> Void
    
    var value: T? {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private var listeners: [ listener ] = []
    
    func bind(_ listener: @escaping listener) {
        listener(value)
        self.listeners.append(listener)
    }
    
}
