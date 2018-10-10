//
//  dragExtension.swift
//  chocoed
//
//  Created by Tejal on 10/10/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation
import UIKit
extension QuizBahaviouralViewController : UIDragInteractionDelegate{
    
    // MARK: - UIDragInteractionDelegate
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        guard let interactionView = interaction.view else { return [] }
        let item: UIDragItem
        
        if interactionView.isEqual(imageView) {
            guard let image = imageView.image else { return [] }
            item = makeDragItem(image: image)
            draggingImageType = .none
            draggingOperationType = .add
        }
        else {
            return []
        }
        return [item]
    }
    
    // MARK: - Helper
    
    private func makeDragItem(image: UIImage) -> UIDragItem {
        let provider = NSItemProvider(object: image)
        return UIDragItem(itemProvider: provider)
    }
}
