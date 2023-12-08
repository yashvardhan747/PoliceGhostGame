//
//  SecondScreenViewController.swift
//  INDMoney
//
//  Created by Astrotalk on 08/12/23.
//

import UIKit

class SecondScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel: SecondScreenViewModel
    
    init?(viewModel: SecondScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.SecondScreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.SecondScreenCollectionViewCell)
    }

}

extension SecondScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.row * viewModel.col
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.SecondScreenCollectionViewCell, for: indexPath) as? SecondScreenCollectionViewCell else {return UICollectionViewCell()}
        let r = indexPath.row
        let c = indexPath.item % viewModel.col
        cell.configure(bgColor: viewModel.getColorFor(r, c))
    }
}
