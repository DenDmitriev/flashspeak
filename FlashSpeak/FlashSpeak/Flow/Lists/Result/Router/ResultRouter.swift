//
//  ResultRouter.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 07.05.2023.
//

import Foundation

protocol ResultEvent {
    var didSendEventClosure: ((ResultRouter.Event) -> Void)? { get }
}

struct ResultRouter: ResultEvent {
    enum Event {
        case learn(list: List)
        case settings
    }
    
    var didSendEventClosure: ((Event) -> Void)?
}
