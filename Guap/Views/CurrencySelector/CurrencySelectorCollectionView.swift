//
//  CurrencySelectorCollectionView.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/12/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class CurrencySelectorCollectionView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        
        layout.estimatedItemSize = CGSize(width: width, height: 1)
        layout.minimumLineSpacing = 0
        
        super.init(collectionViewLayout: layout)
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(CurrencySelectorCell.self, forCellWithReuseIdentifier: CurrencySelectorCell.reuseIdentifier)
        collectionView.backgroundColor = .white
    }
    
}

// MARK: - UICollectionViewDataSource

extension CurrencySelectorCollectionView {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencySelectorCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
    }
    
}

// MARK: - Flow Layout Delegate

extension CurrencySelectorCollectionView {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
