//
//  AppConstants.swift
//  Volgafit
//
//  Created by Alexey Papin on 19.02.17.
//  Copyright © 2017 zzheads. All rights reserved.
//

import Foundation
import UIKit

enum AppFonts {
    case light(size: CGFloat)
    case medium(size: CGFloat)
    case regular(size: CGFloat)
    case bold(size: CGFloat)
    
    var font: UIFont {
        switch self {
        case .light(let size):return UIFont(name: "SanFranciscoDisplay-Light", size: size)!
        case .medium(let size):return UIFont(name: "SanFranciscoDisplay-Medium", size: size)!
        case .regular(let size):return UIFont(name: "SanFranciscoDisplay-Regular", size: size)!
        case .bold(let size):return UIFont(name: "SanFranciscoDisplay-Bold", size: size)!
        }
    }
}
