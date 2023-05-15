//
//  Fonts.swift
//  CoreDataTest
//
//  Created by Denis Dmitriev on 17.04.2023.
//

import UIKit

extension UIFont {
    static var title1: UIFont { UIFont.boldSystemFont(ofSize: 32) }
    
    static var title2: UIFont { UIFont.boldSystemFont(ofSize: 26) }
    
    static var title3: UIFont { UIFont.boldSystemFont(ofSize: 20) }
    
    static var title4: UIFont { UIFont.systemFont(ofSize: 20, weight: .light) }
    
    static var caption1: UIFont { UIFont.boldSystemFont(ofSize: 12) }
    
    static var caption2: UIFont { UIFont.systemFont(ofSize: 10) }
    
    static var subhead: UIFont { UIFont.boldSystemFont(ofSize: 16) }
    
    static var regular: UIFont { UIFont.systemFont(ofSize: 12) }
}
