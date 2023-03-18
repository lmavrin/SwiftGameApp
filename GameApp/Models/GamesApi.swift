//
//  GamesApi.swift
//  GameApp
//
//  Created by Luka Mavrin on 02.12.2022..
//

import Foundation
import Combine
import Alamofire

class GamesApi: ObservableObject {
	// MARK: - Input your API key here (you can get the key from rawg.io)
	var API_KEY = "1a95ef923bde40bcb3ce498255f3125c"
	@Published var list: [Result] = []

	init(){
		var i = 1
		while i < 3 {
			getByPage(page: i) { result in
				self.list.append(contentsOf: result)
			}
			i += 1
		}


	}

	func getGameByName(name: String,completion: @escaping (Result)-> ()){
		AF.request("https://api.rawg.io/api/games/\(name)?key=\(API_KEY)").responseDecodable(of: Result.self) { response in
							if let data = response.value{
								completion(data)
							}
						}
	}

	func getByPage(page: Int,completion: @escaping ([Result])-> ()) {
		AF.request("https://api.rawg.io/api/games?key=1a95ef923bde40bcb3ce498255f3125c&page=\(page)&page_size=40").responseDecodable(of: GameData.self) { response in
			print(response)
			if let data = response.value?.results{
				completion(data)
			}}
	}

	func searchGames(name: String,completion: @escaping ([Result])-> ()){
		let newName = name.replacingOccurrences(of: " ", with: "%")
		let urlString = "https://api.rawg.io/api/games?key=1a95ef923bde40bcb3ce498255f3125c&search=\(newName)&search_precise=true-metacritic"
		if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
		{
			AF.request(url).responseDecodable(of: GameData.self){ response in
				print(response.error as Any)
				print(response)
				if let data = response.value?.results{

					print(response.error?.errorDescription as Any)
					completion(data)
				}
			}
		}

	}
}
