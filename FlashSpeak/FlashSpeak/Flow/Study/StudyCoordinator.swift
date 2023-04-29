//
//  StudyCoordinator.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 27.04.2023.
//

import UIKit

protocol StudyCoordinatorProtocol: Coordinator {
    func showStudy()
    func showLearnSettings()
    func showLearn(list: List)
    func showResult(learn: Learn)
}

class StudyCoordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .lists }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showStudy()
    }
}

extension StudyCoordinator: StudyCoordinatorProtocol {
    
    func showStudy() {
        var router = StudyRouter()
        router.didSendEventClosure = { [weak self] event in
            switch event {
            case .settings:
                self?.showLearnSettings()
            case .learn(list: let list):
                self?.showLearn(list: list)
            case .result(learn: let learn):
                self?.showResult(learn: learn)
            }
        }
        
        let studyViewController = StudyBuilder.build(router: router)
        studyViewController.navigationItem.title = navigationController.tabBarItem.title
        navigationController.pushViewController(studyViewController, animated: true)
    }
    
    func showLearnSettings() {
//        var router = NameRouter()
//        router.didSendEventClosure = { [weak self] event in
//            switch event {
//                case .close:
//                    self?.navigationController.dismiss(animated: true)
//            }
//        }
//        let viewController = NameBuilder.build(router: router)
//        viewController.modalPresentationStyle = .overFullScreen
//        self.navigationController.present(viewController, animated: true)
    }
    
    func showLearn(list: List) {
//        var router = NameRouter()
//        router.didSendEventClosure = { [weak self] event in
//            switch event {
//            case .complete(learn: Learn):
//                self?.showResult(learn: learn)
//            }
//        }
//        let viewController = NameBuilder.build(list: list, router: router)
//        viewController.navigationItem.title = list.title
//        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func showResult(learn: Learn) {
//        var router = NameRouter()
//        router.didSendEventClosure = { [weak self] event in
//            switch event {
//                case .close:
//                    self?.navigationController.dismiss(animated: true)
//            }
//        }
//        let viewController = NameBuilder.build(router: router)
//        viewController.modalPresentationStyle = .overFullScreen
//        self.navigationController.present(viewController, animated: true)
    }
}

extension StudyCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        switch childCoordinator.type {
        default:
            break
        }
    }
}