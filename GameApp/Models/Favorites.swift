//
//  Favorites.swift
//  GameApp
//
//  Created by Luka Mavrin on 01.12.2022..
//

import Foundation
class Favorites: ObservableObject {
	@Published var favoriteGames: [Result] = []
	init(){

		let jsonData = UserDefaults.standard.data(forKey: "favorites")
		do {
			favoriteGames = try JSONDecoder().decode([Result].self, from: jsonData ?? Data())
		} catch {
			print(error.localizedDescription)
		}
	}

	func isEmpty()->Bool{
		return favoriteGames.isEmpty
	}

	func contains(_ game: Result) -> Bool {
		return favoriteGames.filter { $0.id == game.id }.isEmpty
	}

	func add(_ game: Result) {
//		favoriteGames.forEach { item in
//			if !(item.id == game.id){
//				favoriteGames.append(game)
//				objectWillChange.send()
//				save()
//			}
//		}
		if (contains(game)){
			favoriteGames.append(game)
			objectWillChange.send()
			save()
		}
	}

	func remove(_ game: Result) {

		favoriteGames.removeAll(where: { $0.id == game.id })
		objectWillChange.send()
		save()
	}

	func onDelete(offsets: IndexSet) {
		favoriteGames.remove(atOffsets: offsets)
		save()
	}

	func onMove(source: IndexSet, destination: Int) {
		if (destination >= 0) && (destination < favoriteGames.count){
			favoriteGames.move(fromOffsets: source, toOffset: destination)
			save()
		}

	}

	func save() {
		var games: Data = Data()

		do {
			games = try JSONEncoder().encode(self.favoriteGames)
		} catch {
			print(error.localizedDescription)
		}
		UserDefaults.standard.set(games,forKey: "favorites")
	}
}

