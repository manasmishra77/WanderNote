//
//  Utility.swift
//  NoteWander
//
//  Created by Manas Mishra on 28/03/19.
//  Copyright © 2019 manas. All rights reserved.
//

import UIKit

enum DateFormatType: String {
    /// Time
    case time = "HH:mm:ss"
    
    /// Date with hours
    case dateWithTime = "yyyy-MM-dd HH:mm:ss"
    
    /// Date
    case date = "dd-MMM-yyyy"
   
}
extension String
{
    func dropLast(_ n: Int = 1) -> String {
        return String(characters.dropLast(n))
    }
    var dropLast: String {
        return dropLast()
    }
    
}


extension UIView {
    //Adding constraint for: Height, Top, Leading, Trailing
    func addAsSubviewWithFourConstraintsWithConstantHeight(_ superview: UIView, height: CGFloat, top: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        self.frame = superview.bounds
        superview.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
