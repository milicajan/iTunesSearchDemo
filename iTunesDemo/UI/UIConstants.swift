//
//  UIConstants.swift
//  iTunesDemo
//
//  Created by Milica Jankovic on 23/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved

import UIKit

struct Margins {
    static let small10: CGFloat = 10.0
    static let small20: CGFloat = 20.0
}

struct Sizes {
    static let screenSize: CGRect = UIScreen.main.bounds
    static let containerView: CGSize = CGSize(width: Sizes.screenSize.width / 2, height: Sizes.screenSize.height / 2)
    static let albumImageViewSize: CGSize = CGSize(width: 50.0, height: 50.0)
}

struct FontSizes {
    static let title20: CGFloat = 20.0
    static let title17: CGFloat = 17.0
}

struct CornerRadius {
    static let small10: CGFloat = 10.0
    static let small20: CGFloat = 20.0
}

