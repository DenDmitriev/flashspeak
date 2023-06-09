//
//  WordCardsBuilder.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 20.04.2023.
//

import UIKit

struct WordCardsBuilder {
    
    static func build(list: List, router: WordCardsEvent) -> (UIViewController & WordCardsViewInput) {
        let coreData = CoreDataManager.instance
        let presenter = WordCardsPresenter(
            list: list,
            router: router,
            fetchedListResultsController: coreData.initListFetchedResultsController()
        )
        let collectionDelegate = WordCardsCollectionDelegate()
        let collectionDataSource = WordCardsCollectionDataSource()
        let searchBarDelegate = WordCardsSearchBarDelegate()
        
        let viewController = WordCardsViewController(
            title: list.title,
            style: list.style,
            presenter: presenter,
            wordCardsCollectionDataSource: collectionDataSource,
            wordCardsCollectionDelegate: collectionDelegate,
            searchBarDelegate: searchBarDelegate,
            imageFlag: list.addImageFlag
        )
        
        presenter.viewInput = viewController
        collectionDelegate.viewInput = viewController
        collectionDataSource.viewInput = viewController
        searchBarDelegate.viewController = viewController
        
        return viewController
    }
}
