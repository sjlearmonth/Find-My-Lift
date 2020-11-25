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
        button.layer.cornerRadius = 25.0
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
        button.layer.cornerRadius = 25.0
        button.addTarget(self, action: #selector(handleOfferALift), for: .touchUpInside)
        return button
    }()
    
    private lazy var homeTitleView : HomeTitleView = {
        let htv = HomeTitleView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 350.0))
        let greeting: String
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("HH")
        let hours = Int(dateFormatter.string(from: currentDate))!
        
        if hours >= 0 && hours < 12 {
            greeting = "Good Morning, Stephen"
        } else if hours >= 12 && hours < 18 {
            greeting = "Good Afternoon, Stephen"
        } else {
            greeting = "Good Evening, Stephen"
        }
        htv.homeTitleLabel.text = greeting
        
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.clear.cgColor , UIColor.black.cgColor]
//        gradient.locations = [0.85, 1]
//        htv.layer.insertSublayer(gradient, at: 0)
//        gradient.frame = htv.bounds
//        htv.layoutIfNeeded()

        return htv
        
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let cv = UIView()
        cv.frame.size = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2.0)
        return cv
    }()


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        configureScrollView()
        
        authenticateUser()
 
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
        
        configureNavigationBar()
        
        contentView.addSubview(homeTitleView)
        homeTitleView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingRight: 0.0, height: 350.0)
        
        let stackView = UIStackView(arrangedSubviews: [findALiftButton,
                                                       offerALiftButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.anchor(top: homeTitleView.bottomAnchor,
                         left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: 25.0,
                         paddingLeft: 32.0,
                         paddingRight: 32.0)
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.anchor(top: self.view.topAnchor,
                          bottom: self.view.bottomAnchor,
                          paddingTop: 0,
                          paddingBottom: 0)
        scrollView.trail(left: self.view.leadingAnchor,
                         right: self.view.trailingAnchor,
                         leftT: 0,
                         rightT: 0)
        
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;

        contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
    }

    
    private func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLogInVC()
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(handleLogOut))
            navigationItem.rightBarButtonItem?.tintColor = .white
        }
    }
    
    private func presentLogInVC() {
        let controller = LogInVC()
        controller.delegate = self
        controller.modalPresentationStyle = .fullScreen
        self.present(controller.self, animated: true, completion: nil)
    }
    
    private func configureNavigationBar() {
        title = "Home"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = false
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
        authenticateUser()
    }
}

