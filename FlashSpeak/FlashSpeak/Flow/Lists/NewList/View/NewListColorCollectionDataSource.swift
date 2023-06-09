//
//  NewListColorCollectionDataSource.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 20.04.2023.
//
// swiftlint:disable line_length

import UIKit

class NewListColorCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    weak var viewInput: (UIViewController & NewListViewInput)?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewInput?.styles.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ColorCell.identifier,
                for: indexPath
            ) as? ColorCell,
            let style = viewInput?.styles[indexPath.item]
        else { return UICollectionViewCell() }
        
        cell.configure(style: style)
        if style == viewInput?.viewModel.style {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        }
        return cell
    }
}

// swiftlint:enable line_length
