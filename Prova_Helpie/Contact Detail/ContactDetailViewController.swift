//
//  ContactDetailViewController.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 30/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    fileprivate var user: User?
    fileprivate var userPhoto = UIImageView()
    
    fileprivate var userName = UILabel()
    fileprivate var userPhoneNumber = UILabel()
    fileprivate var userEmail = UILabel()
    fileprivate var comments = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDoneRightButton()
        configureUserPhoto()
        configureUserName()
        configurePhoneNumber()
        configureUserEmail()
        configureNotes()
    }
    
    fileprivate func setDoneRightButton() {
        let addContactButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(updateDataBaseViewController))
        self.navigationItem.rightBarButtonItem = addContactButton
    }
    
    @objc fileprivate func updateDataBaseViewController() {
        let editContactVC = EditContactViewController()
        editContactVC.formatUI(forUser: user)
        
        let editNavigationController = UINavigationController()
        editNavigationController.viewControllers = [editContactVC]
        self.present(editNavigationController, animated: true, completion: nil)
    }
    
    fileprivate func configureUserPhoto() {
        view.addSubview(userPhoto)
        userPhoto.backgroundColor = .lightGray
        userPhoto.layer.cornerRadius = 65
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.clipsToBounds = true
        userPhoto.anchorSizes(sizeWidth: 130, sizeHeight: 130)
        userPhoto.anchorEdges(top: self.view.safeAreaLayoutGuide.topAnchor,
                                 left: nil,
                                 right: nil,
                                 bottom: nil,
                                 padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        userPhoto.anchorCenters(centerX: view.centerXAnchor, centerY: nil)
    }
    
    fileprivate func configureUserName() {
        view.addSubview(userName)
        userName.font = UIFont.systemFont(ofSize: 22)

        userName.anchorEdges(top: userPhoto.bottomAnchor,
                             left: self.view.safeAreaLayoutGuide.leftAnchor,
                             right: self.view.safeAreaLayoutGuide.rightAnchor,
                             bottom: nil,
                             padding: .init(top: 25, left: 12, bottom: 0, right: -12))
        userName.backgroundColor = .yellow
        userName.forTitle("Name")
        userName.addBorderToBottom()
    }
    
    fileprivate func configurePhoneNumber() {
        view.addSubview(userPhoneNumber)
        userPhoneNumber.font = UIFont.systemFont(ofSize: 22)

        userPhoneNumber.anchorEdges(top: userName.bottomAnchor,
                                    left: self.view.safeAreaLayoutGuide.leftAnchor,
                                    right: self.view.safeAreaLayoutGuide.rightAnchor,
                                    bottom: nil,
                                    padding: .init(top: 33, left: 12, bottom: 0, right: -12))
        userPhoneNumber.forTitle("Number")
        userPhoneNumber.addBorderToBottom()
    }

    fileprivate func configureUserEmail() {
        view.addSubview(userEmail)
        userEmail.font = UIFont.systemFont(ofSize: 22)

        userEmail.anchorEdges(top: userPhoneNumber.bottomAnchor,
                                    left: self.view.safeAreaLayoutGuide.leftAnchor,
                                    right: self.view.safeAreaLayoutGuide.rightAnchor,
                                    bottom: nil,
                                    padding: .init(top: 33, left: 12, bottom: 0, right: -12))
        userEmail.forTitle("Email")
        userEmail.addBorderToBottom()
    }
    
    fileprivate func configureNotes() {
        view.addSubview(comments)
        comments.font = UIFont.systemFont(ofSize: 22)
        comments.anchorSizes(sizeWidth: nil, sizeHeight: 43)
        comments.anchorEdges(top: userEmail.bottomAnchor,
                             left: self.view.safeAreaLayoutGuide.leftAnchor,
                             right: self.view.safeAreaLayoutGuide.rightAnchor,
                             bottom: nil,
                             padding: .init(top: 16, left: 8, bottom: 0, right: -12))
        comments.textColor = .lightGray
        comments.isEditable = false
    }
    
    func formatUI(forUser user: User) {
        self.user = user
        print(user)
        userName.text = user.name
        userPhoneNumber.text = user.phoneNumber
        userEmail.text = user.email
        comments.text = user.comments
    }
}


