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
	static let dropBoxAccessTokenUID = Key<String?>("dropBoxAccessTokenUID")
}

class LottieDropperKeyChainBridge: NSObject {
	static let shared = LottieDropperKeyChainBridge()

	var dropBoxAccessToken: DBAccessToken? {
		get {
			guard let token = Keychain[.dropBoxAccessToken], let uid = Keychain[.dropBoxAccessTokenUID] else {
				return nil
			}
			return DBAccessToken(accessToken: token , uid:uid)
		}

		set {
			Keychain[.dropBoxAccessToken] = newValue?.accessToken
			Keychain[.dropBoxAccessTokenUID] = newValue?.uid			
		}
	}

}
