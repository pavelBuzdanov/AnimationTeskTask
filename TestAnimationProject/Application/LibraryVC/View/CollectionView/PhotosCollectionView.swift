//
//  PhotosCollectionView.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit

class PhotosCollectionView: UICollectionView {

    //MARK: - Properties
    private var photosData = [PhotoModel]()
        
    var selectImageClousure: ((UIImage)->())?
    
    
    //MARK: - Counstructor
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = CustomCollectionViewLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        
        register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        
        layout.delegate = self
        dataSource = self
        delegate = self
        
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Networking
    private func loadData() {
        NetworkManager.shared.fetchImageData { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data): self?.photosData = data
                case.failure(let error): print(error)
                }
                self?.reloadData()
            }
        }
    }
    
    
}




//MARK: - UICollectionViewDelegate
extension PhotosCollectionView: CustomCollectionViewLayoutDelegate, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell  else { return }
        cell.layer.borderColor = #colorLiteral(red: 0.4784313725, green: 0.3921568627, blue: 0.8862745098, alpha: 1).cgColor
        cell.layer.borderWidth = 2
        
        if let image = cell.image {
            self.selectImageClousure?(image)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.clear.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(photosData[indexPath.item].height/20)
        return height
    }
    
}


//MARK: - UICollectionViewDataSource
extension PhotosCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { fatalError() }
        
        let data = photosData[indexPath.item]
        cell.data = data
        
        return cell
    }
    
}
