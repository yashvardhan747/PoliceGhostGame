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
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        viewModel.updatePoliceLoc()
    }
    
    
    init?(viewModel: SecondScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.generatePoliceAndGhostLoc()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: Constants.SecondScreenCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.SecondScreenCollectionViewCell)
    }

}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SecondScreenViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var inset: CGFloat { 10 }
    private var minimumLineSpacing: CGFloat { 10 }
    private var minimumInteritemSpacing: CGFloat { 10 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
          return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return minimumLineSpacing
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
          return minimumInteritemSpacing
      }

      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat( viewModel.col - 1)
          let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(viewModel.col)).rounded(.down)
          return CGSize(width: itemWidth, height: itemWidth)
      }

      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return viewModel.col * viewModel.row
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.SecondScreenCollectionViewCell, for: indexPath) as? SecondScreenCollectionViewCell else {return UICollectionViewCell()}
          let r = indexPath.item/viewModel.col
          let c = indexPath.item % viewModel.col
          print(c)
          cell.configure(bgColor: viewModel.getColor(r, c))
          return cell
      }

}

//MARK: SecondScreenViewModelDelegate
extension SecondScreenViewController: SecondScreenViewModelDelegate {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}
