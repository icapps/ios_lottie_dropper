//
//  LottieDropperKeychainBridge.swift
//  LottyDropper
//
//  Created by Stijn Willems on 27/03/2017.
//  Copyright © 2017 icapps. All rights reserved.
//

import Foundation
import Stella

extension Keys {
	static let dropBoxAccessToken = Key<String?>("dropBoxAccessToken")
}

class LottieDropperKeyChainBridge: NSObject {
	static let shared = LottieDropperKeyChainBridge()

	var dropBoxAccessToken: String? {
		get {
			return Keychain[.dropBoxAccessToken]
		}
	}

}
