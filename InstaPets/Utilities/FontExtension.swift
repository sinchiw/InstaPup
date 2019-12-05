//
//  FontExtension.swift
//  InstaPets
//
//  Created by Wilmer sinchi on 12/4/19.
//  Copyright © 2019 Wilmer sinchi. All rights reserved.
//

import Foundation
import UIKit

//MARK: testing which font to use

extension UILabel {
    func enableTogglingFontsOnTap() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(_:))))
        isUserInteractionEnabled = true
        tag = -1
    }

    @objc
    func didTap(_ sender: UITapGestureRecognizer) {
        toggleFont()
    }

    func toggleFont() {
        tag += 1
        if allFonts.indices ~= tag {
            setFont(allFonts[tag])
        } else {
            tag = -1
            toggleFont()
        }
    }

    func setFont(_ font: UIFont) {
        self.font = font
        print("font: \(font.fontName) | index: \(tag)")
    }

    var allFonts: [UIFont] {
        return UILabel.allFontNames.compactMap { UIFont(name: $0, size: font.pointSize) }
    }

    static let allFontNames: [String] = {
        var fontNames = [String]()
        UIFont.familyNames.sorted().forEach { familyName in
            UIFont.fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                fontNames.append(fontName)
            }
        }
        return fontNames
    }()
}
