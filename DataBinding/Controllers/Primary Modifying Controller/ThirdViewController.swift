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
    
    @IBOutlet var inputTextFields: [UITextField]!
    private var areFieldsFilled: Bool {
        inputTextFields.allSatisfy { textField in
            !(textField.text?.isEmpty ?? true)
        }
    }
    private var buttonStateObserver: Observer<Bool>?
    
    private var textFields = [UITextField]()
    private var allFieldsObserver: Observer<[UITextField]>?
    
//    private var fieldsFilledRelay = BehaviorRelay(value: false)
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: -方法零
//        fieldsFilledRelay.bind(to: loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
//        let combinedTexts = Observable.combineLatest(inputTextFields.map { $0.rx.text.orEmpty })
//        combinedTexts.map { textFields in
//            textFields.allSatisfy { !$0.isEmpty }
//        }
//        .distinctUntilChanged() // 這將確保只有當值真的發生變化時才發出事件
//        .bind(to: loginButton.rx.isEnabled)
//        .disposed(by: disposeBag)
        
//        let fieldsFilledDriver = Driver.combineLatest(inputTextFields.map { $0.rx.text.orEmpty.asDriver() })
//        fieldsFilledDriver.drive(onNext: { [weak self] texts in
//            let areAllFieldsFilled = texts.allSatisfy { !$0.isEmpty }
//            self?.loginButton.isEnabled = areAllFieldsFilled
////            self?.updateLoginButtonState()
//        }).disposed(by: disposeBag)
        
        // 將每一個 textField 的 text 屬性轉為 observable 並且合併它們
        let textChanges = Observable.merge(inputTextFields.map { $0.rx.text.orEmpty.asObservable() })

        // 當任何 textField 的內容變更時，更新按鈕的狀態
        textChanges.subscribe(onNext: { [weak self] _ in
            let areAllFieldsFilled = self?.inputTextFields.allSatisfy { !$0.text!.isEmpty }
            self?.loginButton.isEnabled = areAllFieldsFilled ?? false
//            self?.updateLoginButtonState()
        })
        .disposed(by: disposeBag)

        
        // MARK: -方法一
//        loginButton.isEnabled = false
        
//        let name = Observer(String())
//        name.value = "Tom"
//        name.value = "Kim"
        
//        let name = Observer("Tom")
//        name.value = "Kim"
//
//        name.bind { value in
//            print(name.value ?? "")
//        }
//
//        name.value = "Kim"
        
//        name.bind { value in
//            print("YO \(name.value ?? "")")
//        }
//        name.value = "Tom"
        
        // MARK: -方法二
//        buttonStateObserver = Observer(false)
//        buttonStateObserver?.bind{ [weak self] isFilled in
//            self?.loginButton.isEnabled = isFilled ?? false
//        }
        
        // MARK: -方法三
//        textFields.append(contentsOf: [firstTextField, secondTextField, thirdTextField])
//        allFieldsObserver = Observer(textFields)
//
//        allFieldsObserver?.bind { textFields in
//            let fieldArray = textFields?.filter { $0.text != "" }
//            self.loginButton.isEnabled = (fieldArray?.count == 3)
//        }
        
    }
    
    @IBAction func judgeBtnState() {
        // MARK: -方法零
//        fieldsFilledRelay.accept(areFieldsFilled)
        
        // MARK: -方法一
//        if firstTextField.text != "" && secondTextField.text != "" && thirdTextField.text != "" {
//            loginButton.isEnabled = true
//        } else {
//            loginButton.isEnabled = false
//        }
        
        // MARK: -方法二
//        buttonStateObserver?.value = areFieldsFilled
        
        // Spaghetti Code
//        let areFieldsFilled = Observer(firstTextField.text != "" && secondTextField.text != "" && thirdTextField.text != "")
//        areFieldsFilled.bind { [weak self] isFilled in
//              self?.loginButton.isEnabled = isFilled ?? false
//        }
        
        
        // MARK: -方法三
//        allFieldsObserver?.value = [firstTextField, secondTextField, thirdTextField]

//        var textFields = [UITextField]()
//        textFields.append(contentsOf: [firstTextField, secondTextField, thirdTextField])
//
//        let allFields = Observer(textFields)
//        allFields.bind { textFields in
//            let fieldArray = textFields?.filter { $0.text != "" }
//            self.loginButton.isEnabled = (fieldArray?.count == 3)
//        }
        
        
        // 這個判斷方式不對，如果第一個欄位字元數大於 3 就會開放點選
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
    
    private func updateLoginButtonState() {
        let areAllFieldsFilled = inputTextFields.allSatisfy { !$0.text!.isEmpty }
        loginButton.isEnabled = areAllFieldsFilled
    }

}

// 另外寫的重複的 Observer Pattern 的 Class
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
