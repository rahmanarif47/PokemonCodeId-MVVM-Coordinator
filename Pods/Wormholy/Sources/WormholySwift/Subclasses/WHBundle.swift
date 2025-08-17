//
//  WhBundle.swift
//  Wormholy-iOS
//
//  Created by Paolo Musolino on 13/04/18.
//  Copyright © 2018 Wormholy. All rights reserved.
//
import UIKit

class WHBundle: Bundle {
    static func getBundle() -> Bundle{
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        let podBundle = Bundle(for: Wormholy.classForCoder())
        if let bundleURL = podBundle.url(forResource: "WormholyResources", withExtension: "bundle"){
            if let bundle = Bundle(url: bundleURL) {
                return bundle
            }
        }
        
        return Bundle(for: Wormholy.classForCoder())
        #endif
    }
}
