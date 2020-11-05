//
//  OpenCurrentChatVC.swift
//  Find My Lift
//
//  Created by Stephen Learmonth on 03/11/2020.
//  Copyright © 2020 Stephen Learmonth. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class OpenCurrentChatCVC: UICollectionViewController {
    
    // MARK: - Properties
    
    private let chatPartner: String
    private var chats = [
        ["ChatPartner":"Louise", "ChatMessages":[
            ["Name":"currentUser", "Message":"Hey Louise, can you accept my lift request in the app?"],
            ["Name":"Louise", "Message":"Sure, but I need a non-smoking lift"],
            ["Name":"currentUser", "Message":"No problem, I gave up years ago"],
            ["Name":"Louise", "Message":"Awesome, I'll have a look for your lift offer now"],
            ["Name":"currentUser", "Message":"Better be quick, two people have already accepted my offer."]]],
        ["ChatPartner":"James", "ChatMessages":[
            ["Name":"currentUser", "Message":"No problem buddy, just click cancel in the app"],
            ["Name":"James","Message":"Thanks mate, are we still on for our Friday night run this week?"],
            ["Name":"currentUser","Message":"Sure buddy, I really need to lose weight, 6:30pm ok?"],
            ["Name":"James","Message":"Sound perfect, don't forget your lift on Wednesday after work"],
            ["Name":"currentUser","Message":"Gotcha, shouldn't need to cancel that one!"]]],
         ["ChatPartner":"Sally", "ChatMessages":[
            ["Name":"currentUser", "Message":"Yeah no probelm, just have a look in the app for lifts I'm offerring this week"],
            ["Name":"Sally", "Message":"Okay, will do, I'm looking to give a lift back to our village"],
            ["Name":"currentUser", "Message":"I'm giving Tom and Barabara a lift back there too on Tuesday"],
            ["Name":"Sally", "Message":"Great, I've something I want to talk to Tom about anyway"],
            ["Name":"currentUser", "Message":"Hope Tom tells you more about the pub quiz next week"],
            ["Name":"Sally", "Message":"I hope so, I've been looking forward to it so much, see ya."]]]]
    
    private var currentChat = [String:Any]()
    private var previousMessage = [String:String]()
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        iv.delegate = self
        return iv
    }()
    
    // MARK: - Lifecycle
    
    init(message: [String:String]) {
        self.chatPartner = message["Name"] ?? ""
        self.previousMessage = message
        switch chatPartner {
        case "Louise":
            currentChat = chats[0]
            let chatMessages:NSMutableArray = currentChat["ChatMessages"] as? NSMutableArray ?? []
            chatMessages.insert(previousMessage, at: 0)
            currentChat = chatMessages
        case "James":
            currentChat = chats[1]
        case "Sally":
            currentChat = chats[2]
        default:
            currentChat = [String:Any]()
        }
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessagesAndUpdateCollectionView()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - API
    
    func fetchMessagesAndUpdateCollectionView() {
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: [0, (self.currentChat["ChatMessages"] as! [[String:String]]).count - 1], at: .bottom, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemGreen.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = self.view.frame
        let bgView = UIView(frame: collectionView.bounds)
        bgView.layer.insertSublayer(gradient, at: 0)
        collectionView.backgroundView = bgView
        
        title = "Current Chats"
        navigationItem.backButtonTitle = ""

        navigationController?.navigationBar.barTintColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        navigationController?.navigationBar.barStyle = .black

        
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
}

extension OpenCurrentChatCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (currentChat["ChatMessages"] as! [[String:String]]).count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        cell.message = (currentChat["ChatMessages"] as! [[String:String]])[indexPath.row]
        return cell
    }
}

extension OpenCurrentChatCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedSizeCell = MessageCell(frame: frame)
        estimatedSizeCell.message = (currentChat["ChatMessages"] as! [[String:String]])[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

extension OpenCurrentChatCVC: CustomInputAccessoryViewDelegate {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
        
        let message = ["Name":"currentUser", "Message":message]
        let chatMessages:NSMutableArray = currentChat["ChatMessages"] as? NSMutableArray ?? []
        chatMessages.add(message)
        
        inputView.clearMessageText()
    }
}
