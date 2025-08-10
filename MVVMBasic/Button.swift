//
//  Button.swift
//  MVVMBasic
//
//  Created by Jimin on 8/10/25.
//

import UIKit

class Button: UIButton {
    
    private let mbtiTitle: String
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(title: String) {
        self.mbtiTitle = title
        super.init(frame: .zero)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitle(mbtiTitle, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        updateAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? .systemBlue : .white
        setTitleColor(isSelected ? .white : .gray, for: .normal)
        layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.gray.cgColor
    }
}
