//
//  ListsViewController.swift
//  Lingocard
//
//  Created by Denis Dmitriev on 12.04.2023.
//
// swiftlint:disable weak_delegate

import UIKit

class ListsViewController: UIViewController {
    
    // MARK: - Properties
    
    var listCellModels = [ListCellModel]()
    var serachListCellModels = [ListCellModel]()
    var isSearching: Bool = false
    var presenter: ListsViewOutput
    
    // MARK: - Private properties
    
    private let listsCollectionDataSource: UICollectionViewDataSource?
    private let listsCollectionDelegate: UICollectionViewDelegate?
    private let searchController = UISearchController(searchResultsController: nil)
    private let searchResults: (UISearchResultsUpdating & UISearchBarDelegate)?
    
    // MARK: - Constraction
    
    init(
        presenter: ListsViewOutput,
        listsCollectionDataSource: UICollectionViewDataSource,
        listsCollectionDelegate: UICollectionViewDelegate,
        searchResultsController: (UISearchResultsUpdating & UISearchBarDelegate)
    ) {
        self.presenter = presenter
        self.listsCollectionDataSource = listsCollectionDataSource
        self.listsCollectionDelegate = listsCollectionDelegate
        self.searchResults = searchResultsController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var listsView: ListsView {
        return view as? ListsView ?? ListsView()
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = ListsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController() 
        presenter.subscribe {}
        configureButtons()
        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .tintColor
    }
    
    // MARK: - Private functions
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = searchResults
        searchController.searchBar.delegate = searchResults
        navigationItem.searchController = searchController
    }
    
    private func configureButtons() {
        listsView.newListButton.addTarget(
            self,
            action: #selector(didTapNewList(sender:)),
            for: .touchUpInside
        )
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: listsView.changeLanguageButton)
        listsView.changeLanguageButton.addTarget(
            self,
            action: #selector(didTapLanguage(sender:)),
            for: .touchUpInside
        )
    }
      
    private func configureCollectionView() {
        listsView.collectionView.delegate = listsCollectionDelegate
        listsView.collectionView.dataSource = listsCollectionDataSource
        listsView.collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
//        presenter.getStudy()
    }
    
    // MARK: - Actions
    
    @objc private func didTapNewList(sender: UIButton) {
        didTapNewList()
    }
    
    @objc private func didTapLanguage(sender: UIButton) {
        didTapLanguage()
    }
    
}

extension ListsViewController: ListsViewInput {
    
    
    // MARK: - Functions
    
    func didTapLanguage() {
        presenter.changeLanguage()
    }
    
    func didTapNewList() {
        presenter.newList()
    }
    
    func didSelectList(indexPath: IndexPath) {
        presenter.prepareLearn(at: indexPath)
    }
    
    func reloadListsView() {
        listsView.collectionView.reloadData()
    }
    
    func configureLanguageButton(language: Language) {
        listsView.configureChangeButton(language: language)
    }
    
    func deleteList(at indexPath: IndexPath) {
        // already updated from presenter.controllerDidChangeContent(_ controller:)
    }
    
    func setPlaceHolders(isActive: Bool) {
        listsView.setPlaceHolders(isActive: isActive)
    }
}

// swiftlint:enable weak_delegate
