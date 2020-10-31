//
//  EditContactViewController.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 29/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class EditContactViewController: UIViewController {
    
    var userToEdit: User?
    fileprivate var photoURL: String? = ""
    fileprivate var userPhoto = UIImageView()
    fileprivate var changePhotoBottom = UIButton()
    fileprivate var userName = UITextField()
    fileprivate var userPhoneNumber = UITextField()
    fileprivate var userEmail = UITextField()
    fileprivate var comments = UITextView()
    
    fileprivate let realmService = RealmService.shared
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        formatUI()
    }
    
    fileprivate func formatUI() {
        if let user = userToEdit {
            self.title = "Edit Contact"
            userName.text = user.name
            userPhoneNumber.text = user.phoneNumber
            userEmail.text = user.email
            comments.text = user.comments
        } else {
            self.title = "New Contact"
            userPhoto.image = UIImage(systemName: "photo")
        }
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

        guard let uName = userName.text,
              let uPhone = userPhoneNumber.text,
              let uEmail = userEmail.text,
              let uphoto = photoURL else {
              // TODO: add alert(Fill all fields)
              return
        }
        
        if let editedUser = userToEdit {
            //edit user data
            let userData: [String: Any?] = ["name": uName,
                                            "phoneNumber": uPhone,
                                            "photoURL": uphoto,
                                            "comments": comments.text,
                                            "email": uEmail]
            realmService.update(editedUser, with: userData)
        } else {
            //format new user
            let newUser = User(name: uName,
                               phoneNumber: uPhone,
                               photoUrl: uphoto,
                               comments: comments.text,
                               email: uEmail)
            realmService.addObject(newUser)
        }
        // TODO: Alert(success)
        dismissViewController()
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
        changePhotoBottom.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
    }
    
    @objc fileprivate func selectPhoto() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        myPickerController.allowsEditing = true
        self.present(myPickerController, animated: true, completion: nil)
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

extension EditContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            userPhoto.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userPhoto.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
}
