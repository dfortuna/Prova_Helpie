//
//  ContactTableViewCell.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 28/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    fileprivate var contactNameLabel = UILabel()
    fileprivate var user: User?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureContactNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureContactNameLabel() {
        self.addSubview(contactNameLabel)
        contactNameLabel.font = UIFont.systemFont(ofSize: 20)
        contactNameLabel.numberOfLines = 1
        contactNameLabel.anchorEdges(top: self.topAnchor,
                                     left: self.leftAnchor,
                                     right: self.rightAnchor,
                                     bottom: self.bottomAnchor,
                                     padding: .init(top: 10, left: 20, bottom: -10, right: -4))
    }
    
    func formatUI(forContact contact: User) {
        user = contact
        contactNameLabel.text = contact.name
    }

}
