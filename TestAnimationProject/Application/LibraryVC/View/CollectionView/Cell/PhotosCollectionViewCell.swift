//
//  PhotosCollectionViewCell.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "PhotosCollectionViewCell"
    

    var data: PhotoModel? {
        didSet {
            if let data = data {
                self.configureCell(with: data.urls.small!)
            }
        }
    }
    
    var image: UIImage?
    
    
    //MARK: - Views
    private let imageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    
    
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    
    //MARK: - SetupCell
    private func setupCell(){
        layoutCell()
    }
    
    
    //MARK: - Configure Cell
    private func configureCell(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        ImageLoader.shared.loadImage(url) { [weak self] (result) in
            switch result {
            case.success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                    self?.image = image
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    
    
    //MARK: - Layout Cell
    private func layoutCell() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    
}
