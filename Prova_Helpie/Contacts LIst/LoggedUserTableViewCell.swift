//
//  LoggedUserTableViewCell.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 28/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class LoggedUserTableViewCell: UITableViewCell {
    
    fileprivate var contactName = UILabel()
    fileprivate var messageLabel = UILabel()
    fileprivate var contactPhoto = UIImageView()
    fileprivate var loggedUser: User?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureContactPhoto()
        configureContactNameLabel()
        configurePersonalMessage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureContactPhoto() {
        self.addSubview(contactPhoto)
        contactPhoto.backgroundColor = .lightGray
        contactPhoto.anchorSizes(sizeWidth: 70, sizeHeight: 70)
        contactPhoto.layer.cornerRadius = 35
        contactPhoto.layer.borderColor = UIColor.blue.cgColor
        contactPhoto.layer.borderWidth = 5
        contactPhoto.contentMode = .scaleAspectFill
        contactPhoto.clipsToBounds = true
        contactPhoto.anchorEdges(top: self.topAnchor,
                                 left: self.leftAnchor,
                                 right: nil,
                                 bottom: self.bottomAnchor,
                                 padding: .init(top: 8, left: 8, bottom: -8, right: 0))
    }
    
    fileprivate func configureContactNameLabel() {
        self.addSubview(contactName)
        contactName.font = UIFont.boldSystemFont(ofSize: 20)
        contactName.numberOfLines = 0

        contactName.anchorEdges(top: self.topAnchor,
                               left: contactPhoto.rightAnchor,
                               right: nil,
                               bottom: nil,
                               padding: .init(top: 15, left: 10, bottom: 0, right: 0))
    }
    
    fileprivate func configurePersonalMessage() {
        self.addSubview(messageLabel)
        messageLabel.font = UIFont.italicSystemFont(ofSize: 16)
        messageLabel.textColor = .lightGray
        messageLabel.numberOfLines = 1
        messageLabel.anchorEdges(top: contactName.bottomAnchor,
                               left: contactPhoto.rightAnchor,
                               right: self.rightAnchor,
                               bottom: nil,
                               padding: .init(top: 6, left: 10, bottom: 0, right: 0))
        
    }
    
    func formatUI(forUser user: User) {
        loggedUser = user
        contactName.text = user.name
        messageLabel.text = user.comments
    }
}
