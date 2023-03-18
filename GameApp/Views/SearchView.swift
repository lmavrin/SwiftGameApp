//
//  SearchView.swift
//  GameApp
//
//  Created by Luka Mavrin on 05.12.2022..
//

import SwiftUI

struct SearchView: View {

	@State var animate = false
	@State var animate2 = false
	@State var searchedGames: [Result] = []
	@EnvironmentObject var games: GamesApi
	var gridLayout: [GridItem] {
		if UIDevice.current.userInterfaceIdiom == .pad{
			return [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible()), GridItem(.flexible())]
		}
		return [GridItem(.flexible()), GridItem(.flexible())]
	}
	var backgroundColor = [Color("backgroundColor1"),Color("backgroundColor2")]
	@State var searchText = ""
	@Binding var selectedTab: Tab

    var body: some View {
			NavigationStack{
				ZStack{
					CircleBackground(color: Color("blueCircle")).blur(radius: animate ? 30 : 100).offset(x: animate ? -50 : -130, y: animate ? -30 : -100).task{
						withAnimation(.easeInOut(duration: 7).repeatForever()){
							animate.toggle()
						}
					}
					CircleBackground(color: Color("pinkCircle")).blur(radius: animate2 ? 30 : 100).offset(x: animate2 ? 100 : 130, y: animate2 ? 150 : 100)
						.task{
							withAnimation(.easeInOut(duration: 7).repeatForever()){
								animate2.toggle()
							}
						}
					ScrollView{
						VStack{
							Text("Find a game").fontWeight(.bold).font(.title3).foregroundColor(.white)
							CustomSearchBar(searchText: $searchText).padding(EdgeInsets(top: 30, leading: 20, bottom: 20, trailing: 20)).onSubmit {
								runSearch(searchText)
							}
							if searchedGames.isEmpty {
								Text("There are no results for your search").foregroundColor(.white)
							} else {
								ZStack {
									LazyVGrid(columns: gridLayout) {
										ForEach(searchedGames) { gm in
											NavigationLink( destination: GameDetailsView(game: gm, selectedTab: $selectedTab)) {
												//TODO: mage a game row
												GameCard(game: gm)
											}
											//nav link
										}
									}.navigationBarTitle("Favorites")
									Spacer().padding(.bottom,100)
								}
							}

						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

					}

				}.background(
					LinearGradient(colors: backgroundColor, startPoint: .bottom, endPoint: .top)
				).ignoresSafeArea(.keyboard)
			}.accentColor(.white)

    }
	func runSearch(_ text: String) {
		if text == ""{
			searchedGames = []
		}
		games.searchGames(name: text) { games in
			searchedGames = games
		}
	}
}
