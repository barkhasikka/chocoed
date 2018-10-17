//
//  dropExtension.swift
//  chocoed
//
//  Created by Tejal on 10/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//
import UIKit
import Foundation
import MobileCoreServices
//
//extension QuizBahaviouralViewController: UIDropInteractionDelegate {
//    
//    // MARK: - UIDropInteractionDelegate
//    
//    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
//        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]) && session.items.count == 1
//    }
//    
//    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
//        let dropLocation = session.location(in: view)
//        let operation: UIDropOperation
//        switch draggingOperationType {
//        case .add:
//            if imageView.frame.contains(dropLocation) {
//                operation = .copy
//            } else {
//                operation = .cancel 
//            }
//        case .remove:
//            if dragCircle.frame.contains(dropLocation) {
//                operation = .move
//            } else {
//                operation = .cancel
//            }
//        }
//        return UIDropProposal(operation: operation)
//    }
//    
//    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
//        
//        session.loadObjects(ofClass: UIImage.self) { [weak self] imageItems in
//            guard let me = self else { return }
//            guard let images = imageItems as? [UIImage] else { return }
//            let image = me.draggingOperationType == .add ? images.first : nil
//            
//            switch me.draggingImageType {
////            case .afro:
////                me.imageView.image = image
////            case .mask:
////                me.maskContainerImageView.image = image
//            case .none:
//                me.imageView.image = image
//            }
//            
//            me.draggingImageType = .none
//            me.draggingOperationType = .add
//        }
//    }
//}
