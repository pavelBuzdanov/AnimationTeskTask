//
//  ViewController.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //MARK: - Properties
    var image: UIImage? {
        didSet {
            if let image = image {
                self.templateView.image = image
                self.templateImageView.image = image
            }
        }
    }
    
    
    //MARK: - Views
    private let openLibraryButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "gallery"), for: .normal)
        button.addTarget(self, action: #selector(openLibraryButtonTapped), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private let seeTemplateButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "eyeImage"), for: .normal)
        button.addTarget(self, action: #selector(seeTemplateButtonTapped), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    private lazy var templateView: TemplateView = {
       let view = TemplateView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    

    private let templateImageView: UIImageView = {
       let view = UIImageView()
      
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    
    //MARK: - SetupView
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1098039216, blue: 0.1607843137, alpha: 1)
        layoutView()
    }
    
    
    //MARK: - Private functions
    @objc private func openLibraryButtonTapped() {
        let vc = PhotosViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.rootViewController = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @objc private func seeTemplateButtonTapped() {
        templateView.isOnTheScreen = true
    }
    
    
    
    //MARK: - Layout View
    private func layoutView() {
        view.addSubview(seeTemplateButton)
        view.addSubview(templateImageView)
        view.addSubview(openLibraryButton)
        view.addSubview(templateView)
        
        NSLayoutConstraint.activate([
            seeTemplateButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            seeTemplateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            seeTemplateButton.widthAnchor.constraint(equalToConstant: 36),
            seeTemplateButton.heightAnchor.constraint(equalToConstant: 36),
            
            openLibraryButton.widthAnchor.constraint(equalToConstant: 30),
            openLibraryButton.heightAnchor.constraint(equalToConstant: 30),
            openLibraryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openLibraryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            templateImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            templateImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            templateImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            templateImageView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.7 ),
            
            templateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            templateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            templateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            templateView.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.6 ),
        ])
    }
}


extension MainViewController: TemplateViewDelegate {
    func deleteView() {
        templateView.isOnTheScreen = false
    }
    
    
}

