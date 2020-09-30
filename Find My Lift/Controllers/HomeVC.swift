//
//  HomeVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 29/09/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let findALiftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find A Lift", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleFindALift), for: .touchUpInside)
        return button
    }()
    
    private let offerALiftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Offer A Lift", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleOfferALift), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [findALiftButton, offerALiftButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        return stackView
    }()


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
 
    }
    
    // MARK: - Selectors
    
    @objc func handleFindALift() {
        let controller = LiftRequestDetailsVC()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleOfferALift() {
        let controller = LiftOfferDetailsVC()
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helper Functions
    
    private func configureUI() {
        
        configureGradientLayer()
        
        title = "Home"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(handleLogOut))

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(buttonsStackView)
        buttonsStackView.centerY(inView: view)
        buttonsStackView.anchor(left: view.leftAnchor, right: view.rightAnchor,
                                paddingLeft: 32, paddingRight: 32)

    }
    
    @objc func handleLogOut() {
            do {
                try Auth.auth().signOut()
                DispatchQueue.main.async {
                    let controller = LogInVC()
                    controller.delegate = self
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller.self, animated: true, completion: nil)
                }
            } catch {
                print("DEBUG: Error signing out. \(error.localizedDescription)")
            }
    }

}

extension HomeVC: AuthenticationDelegate {
    func completeAuthentication() {
        dismiss(animated: true, completion: nil)
        configureUI()
    }
}

