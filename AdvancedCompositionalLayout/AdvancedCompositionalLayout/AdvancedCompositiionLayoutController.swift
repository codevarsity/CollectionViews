//
//  AdvancedCompositiionLayoutController.swift
//  AdvancedCompositionalLayout
//
//  Created by Amit Gulati on 03/03/23.
//

import UIKit

private let reuseIdentifier = "cell"

class AdvancedCompositiionLayoutController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        collectionView.setCollectionViewLayout(createLayout(), animated: true)
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 10
        case 1:
            return 20
        case 2:
            return 15
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let view = cell.viewWithTag(101) {
            view.backgroundColor = randomColor()
        }
    
        return cell
    }
    
    func randomColor()->UIColor {
        let red:CGFloat = CGFloat.random(in: 0...1.0)
        let green:CGFloat = CGFloat.random(in: 0...1.0)
        let blue:CGFloat = CGFloat.random(in: 0...1.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func createLayout()->UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            
            switch sectionIndex {
            case 0:
                return self.createPromotedSection()
            case 1:
                return self.createStandardSection()
            case 2:
                return self.createCategoriesSection()
            default:
                return nil
            }

        }
        return layout
    }
    
    func createPromotedSection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension:
                       .fractionalWidth(1),
                       heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4,
           bottom: 0, trailing: 4)
        let groupSize =
                       NSCollectionLayoutSize(widthDimension:
                       .fractionalWidth(0.92),
                       heightDimension: .estimated(300))
        let group =
                       NSCollectionLayoutGroup.horizontal(layoutSize:
                       groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    func createStandardSection()->NSCollectionLayoutSection {
        let itemSize =
               NSCollectionLayoutSize(widthDimension:
              .fractionalWidth(1), heightDimension: .fractionalWidth(1/3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
            let groupSize =
               NSCollectionLayoutSize(widthDimension:
               .fractionalWidth(0.92), heightDimension: .estimated(250))
            let group = NSCollectionLayoutGroup.vertical(layoutSize:
               groupSize, subitem: item, count: 3)
    
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
    
            return section
    }
    
    
    func createCategoriesSection()->NSCollectionLayoutSection {
        let itemSize =
               NSCollectionLayoutSize(widthDimension:
               .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
            let groupSize =
               NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
               heightDimension: .estimated(44))
            let group = NSCollectionLayoutGroup.vertical(layoutSize:
               groupSize, subitems: [item])
        
            let section = NSCollectionLayoutSection(group: group)
            return section
    }
    


}
