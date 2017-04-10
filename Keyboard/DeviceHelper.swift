//
//  DeviceHelper.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/7/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

struct Build {
#if DEBUG
    static let DEBUG = true
#else
    static let DEBUG = false
#endif
}

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}

struct Orientation {
    static let IS_PORTRAIT = ScreenSize.SCREEN_WIDTH <  ScreenSize.SCREEN_HEIGHT
    static let IS_LANDSCAPE = !Orientation.IS_PORTRAIT
}
