//
//  EditContactViewController.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 29/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {

    fileprivate var userPhoto = UIImageView()
    fileprivate var changePhotoBottom = UIButton()
    fileprivate var userName = UITextField()
    fileprivate var userPhoneNumber = UITextField()
    fileprivate var userEmail = UITextField()
    fileprivate var comments = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setDoneRightButton()
        setCancelLeftButton()
        configureUserPhoto()
        configureChangePhotoButton()
        configureUserName()
        configurePhoneNumber()
        configureUserEmail()
        configureNotes()
    }
    
    fileprivate func setCancelLeftButton() {
        let addCancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissViewController))
        self.navigationItem.leftBarButtonItem = addCancelButton
    }
    
    @objc fileprivate func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setDoneRightButton() {
        let addDoneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(updateDataBaseViewController))
        self.navigationItem.rightBarButtonItem = addDoneButton
    }
    
    @objc fileprivate func updateDataBaseViewController() {
        // TODO: update database
        dismissViewController()
    }
    
    fileprivate func configureUserPhoto() {
        view.addSubview(userPhoto)
        userPhoto.backgroundColor = .lightGray
        userPhoto.layer.cornerRadius = 65
        userPhoto.layer.borderColor = UIColor.blue.cgColor
        userPhoto.layer.borderWidth = 5
        userPhoto.contentMode = .scaleAspectFill
        userPhoto.clipsToBounds = true
        userPhoto.anchorSizes(sizeWidth: 130, sizeHeight: 130)
        userPhoto.anchorEdges(top: self.view.safeAreaLayoutGuide.topAnchor,
                                 left: nil,
                                 right: nil,
                                 bottom: nil,
                                 padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        userPhoto.anchorCenters(centerX: view.centerXAnchor, centerY: nil)
    }
    
    fileprivate func configureChangePhotoButton() {
        view.addSubview(changePhotoBottom)
        changePhotoBottom.setTitle("Change Photo", for: .normal)
        changePhotoBottom.anchorEdges(top: userPhoto.bottomAnchor,
                                      left: nil,
                                      right: nil,
                                      bottom: nil,
                                      padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        changePhotoBottom.anchorCenters(centerX: userPhoto.centerXAnchor, centerY: nil)
        changePhotoBottom.setTitleColor(.systemBlue, for: .normal)
    }
    
    fileprivate func configureUserName() {
        view.addSubview(userName)
        userName.font = UIFont.systemFont(ofSize: 22)

        userName.anchorEdges(top: changePhotoBottom.bottomAnchor,
                             left: self.view.safeAreaLayoutGuide.leftAnchor,
                             right: self.view.safeAreaLayoutGuide.rightAnchor,
                             bottom: nil,
                             padding: .init(top: 15, left: 12, bottom: 0, right: -12))
        userName.addBorderToBottom()
        userName.placeholder = "Name"
    }
    
    fileprivate func configurePhoneNumber() {
        view.addSubview(userPhoneNumber)
        userPhoneNumber.font = UIFont.systemFont(ofSize: 22)

        userPhoneNumber.anchorEdges(top: userName.bottomAnchor,
                                    left: self.view.safeAreaLayoutGuide.leftAnchor,
                                    right: self.view.safeAreaLayoutGuide.rightAnchor,
                                    bottom: nil,
                                    padding: .init(top: 12, left: 12, bottom: 0, right: -12))
        userPhoneNumber.addBorderToBottom()
        userPhoneNumber.placeholder = "Number"
    }

    fileprivate func configureUserEmail() {
        view.addSubview(userEmail)
        userEmail.font = UIFont.systemFont(ofSize: 22)

        userEmail.anchorEdges(top: userPhoneNumber.bottomAnchor,
                                    left: self.view.safeAreaLayoutGuide.leftAnchor,
                                    right: self.view.safeAreaLayoutGuide.rightAnchor,
                                    bottom: nil,
                                    padding: .init(top: 12, left: 12, bottom: 0, right: -12))
        userEmail.addBorderToBottom()
        userEmail.placeholder = "Email"
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
        comments.delegate = self
        comments.textColor = .systemGray3
        comments.backgroundColor = .systemGray5
        comments.text = "Notes"
    }
    
    func formatUI(forUser user: User?) {
        if let user = user {
            userName.text = user.name
            userPhoneNumber.text = user.phoneNumber
            userEmail.text = user.email
            comments.text = user.comments
            self.title = "Edit Contact"
        } else {
            self.title = "New Contact"
            userPhoto.image = UIImage(systemName: "photo")
        }
    }
}

extension EditContactViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        comments.text = ""
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.comments.dynamicHeight(forWidth: self.view.bounds.width)
        if textView.text.isEmpty  {
            comments.text = "Notes"
        } else if comments.text.starts(with: "Notes") {
            comments.text = textView.text.components(separatedBy: "Notes")[1]
        }
    }
}
