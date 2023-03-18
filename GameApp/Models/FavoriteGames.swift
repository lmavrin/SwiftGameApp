//
//  FavoriteGames.swift
//  GameApp
//
//  Created by Luka Mavrin on 02.12.2022..
//

import Foundation
import Combine
import Alamofire
import SwiftUI


class FavoriteGames: ObservableObject {
	@Published var list: [Game] = []
	@State var favorites: Favorites

	init() {
		


	}


}
