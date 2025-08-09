//
//  OnboardingViewController.swift
//  MVVMBasic
//
//  Created by Jimin on 8/10/25.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private let button = {
        let button = UIButton()
        button.setTitle("프로필 설정", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(100)
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
        navigationItem.backButtonTitle = ""
    }
}
