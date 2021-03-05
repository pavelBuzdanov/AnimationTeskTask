//
//  PhotosViewController.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 04.03.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: - Properties
    var image: UIImage?
    
    weak var rootViewController: MainViewController?

    //MARK: - Views
    private let collectionView = PhotosCollectionView()
    
    private let bottomView = BottomView()
    
    private let topLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "Unspash"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Life cycle 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1098039216, blue: 0.1607843137, alpha: 1)
        layoutView()
        
        
        
        bottomView.doneClousure = {  [weak self] in
            self?.rootViewController?.image = self?.image
            self?.dismiss(animated: true, completion: nil)
        }
        
        bottomView.cancelClousure = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        collectionView.selectImageClousure = {  [weak self] (image) in
            self?.image = image
        }
        
    }
    
    
    
    //MARK: - Private
    
    private func addBottomBorder(to view: UIView,with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - borderWidth, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }
 
    
    
    
    
    //MARK: - LayoutView
    private func layoutView(){
        view.addSubview(topLabel)
        view.addSubview(collectionView)
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            topLabel.heightAnchor.constraint(equalToConstant: 32),
            topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            bottomView.heightAnchor.constraint(equalToConstant: 76),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            collectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
        
        addBottomBorder(to: topLabel, with: #colorLiteral(red: 0.4784313725, green: 0.3921568627, blue: 0.8862745098, alpha: 1), andWidth: 2)
    }
    
    
    
    

}
