//
//  ListMakerDropDelegate.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 24.04.2023.
//
// swiftlint:disable line_length

import UIKit

class ListMakerDropDelegate: NSObject, UICollectionViewDropDelegate {
    
    weak var viewController: (UIViewController & ListMakerViewInput)?
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView == viewController?.tokenCollection {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            
        } else {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            return  UICollectionViewDropProposal(operation: .move, intent: .unspecified)
        }
        
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        // drop inside self collection
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let item = collectionView.numberOfItems(inSection: .zero)
            destinationIndexPath = IndexPath(item: item - 1, section: .zero)
        }
        // drop to remove area
        if coordinator.proposal.operation == .move {
            if coordinator.proposal.intent == .insertAtDestinationIndexPath {
                self.reorederItems(
                    coordinator: coordinator,
                    destinationIndexPath: destinationIndexPath,
                    collectionView: collectionView
                )
            } else {
                self.removeItems(
                    coordinator: coordinator,
                    destinationIndexPath: destinationIndexPath,
                    collectionView: collectionView
                )
            }
        }
    }
    
    private func reorederItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        for item in coordinator.items {
            guard
                let sourceIndexPath = item.sourceIndexPath,
                let identifier = item.dragItem.localObject as? String
            else { return }
            collectionView.performBatchUpdates {
                viewController?.tokens.remove(at: sourceIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                viewController?.tokens.insert(identifier, at: destinationIndexPath.item)
                collectionView.insertItems(at: [destinationIndexPath])
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
    
    private func removeItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        for item in coordinator.items {
            guard
                let identifier = item.dragItem.localObject as? String,
                let index = viewController?.tokens.firstIndex(of: identifier)
            else { return }
            let indexPath = IndexPath(row: index, section: .zero)
            viewController?.deleteToken(indexPaths: [indexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidExit session: UIDropSession) {
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
        viewController?.highlightRemoveArea(isActive: false)
        viewController?.highlightTokenField(isActive: false)
    }
}

// swiftlint:enable line_length
