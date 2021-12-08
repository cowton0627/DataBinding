//
//  Observable.swift
//  DataBinding
//
//  Created by Chun-Li Cheng on 2021/12/8.
//

import Foundation

//// Obserable
//class Observable<T> {
////    var value: T? {
////        didSet {
////            listener?(value)
////        }
////    }
//
//    var value: T? {
//        didSet {
//            listeners.forEach {
//                $0(value)
//            }
//        }
//    }
//
//    init(_ value: T?) {
//        self.value = value
//    }
//
////    private var listener: ((T?) -> Void)?
//    private var listeners: [((T?) -> Void)] = []
//
//
////    func bind(_ listener: @escaping (T?) -> Void) {
////        listener(value)
////        self.listener = listener
////    }
//
//    func bind(_ listener: @escaping (T?) -> Void) {
//        listener(value)
//        self.listeners.append(listener)
//    }
//
//}

