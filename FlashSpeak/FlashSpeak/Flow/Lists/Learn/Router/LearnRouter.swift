//
//  LearnRouter.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 04.05.2023.
//

import Foundation

protocol LearnEvent {
    var didSendEventClosure: ((LearnRouter.Event) -> Void)? { get set }
}

struct LearnRouter: LearnEvent {
    enum Event {
        case complete(list: List, mistakes: [Word: String])
    }
    
    var didSendEventClosure: ((Event) -> Void)?
}
