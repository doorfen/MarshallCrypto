//
//  Text+Extension.swift
//  MarshallCrypto
//
//  Created by David Geijer on 2024-09-13.
//

import SwiftUI

extension Text {
    
    func appFontRegular16() -> Text {
        self.font(Font.custom("OpenSans-Regular", size: 16))
    }
    
    func appFontSemiBold16() -> Text {
        self.font(Font.custom("OpenSans-SemiBold", size: 16))
    }
}
