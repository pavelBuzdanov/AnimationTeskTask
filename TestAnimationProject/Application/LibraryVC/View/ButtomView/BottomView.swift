//
//  BottomView.swift
//  TestAnimationProject
//
//  Created by Pavel Buzdanov on 05.03.2021.
//

import UIKit

class BottomView: UIView {
    
    //MARK: - Properties
    var cancelClousure: (()->())?
    
    var doneClousure: (()->())?
    
    //MARK: - Views
    private let cancelButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let doneButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()

   
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup View
    private func setupView() {
        layoutView()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = superview?.backgroundColor
        
    }
    
    
    //MARK: - Private
    @objc private func cancelButtonTapped() {
        cancelClousure?()
    }
    
    
    @objc private func doneButtonTapped() {
        doneClousure?()
    }
    
    
    //MARK: - Layout view
    private func layoutView() {
        addSubview(cancelButton)
        addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            doneButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }

}
