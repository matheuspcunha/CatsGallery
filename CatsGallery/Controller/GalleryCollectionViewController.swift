//
//  GalleryCollectionViewController.swift
//  CatsGallery
//
//  Created by Matheus Cunha on 10/06/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties

    lazy var viewModel = GalleryViewModel()

    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        viewModel.imagesLoaded = imagesLoaded
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadImages()
    }

    func imagesLoaded() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                               heightDimension: .fractionalHeight(1.0))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5,
                                                      bottom: 5, trailing: 5)
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .fractionalWidth(0.33))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                        subitem: item, count: 3)
         let section = NSCollectionLayoutSection(group: group)
         let layout = UICollectionViewCompositionalLayout(section: section)
        
         return layout
     }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.cellViewModelFor(at: indexPath))
        return cell
    }
}
