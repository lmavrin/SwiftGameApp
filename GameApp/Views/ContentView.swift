//
//  ContentView.swift
//  GameApp
//
//  Created by Luka Mavrin on 01.12.2022..
//

import SwiftUI
import Alamofire
enum Tab: String, CaseIterable {
	case games = "gamecontroller.fill"
	case favorites = "heart.fill"
	case search	= "magnifyingglass.circle.fill"
//	case personalGames = "folder.circle.fill"
}

struct ContentView: View {
	@EnvironmentObject var games: GamesApi
	@EnvironmentObject var favorites: Favorites
	@ObservedObject var networkManager = NetworkManager()
	@State var showFavorites = false

	@State var show = true

	@State private var selectedTab: Tab = .games
	let coloredNavAppearance = UINavigationBarAppearance()
	var backgroundColors = [UIColor.purple,UIColor.cyan,UIColor.systemPink]

	init() {
		UITabBar.appearance().isHidden = true

		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.black]
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white]
		
	}

	var body: some View {
		if networkManager.isConnected{
			ZStack(alignment: .bottom){
				VStack {
					TabView(selection: $selectedTab){
						GamesListView(selectedTab: $selectedTab).environmentObject(favorites)
							.tabItem {
								Image(systemName: "gamecontroller.fill")
								Text("games")
							}
							.tag(Tab.games)//end of games preview
						SearchView(selectedTab: $selectedTab).environmentObject(favorites)
							.tabItem {
								Image(systemName: "gamecontroller.fill")
								Text("games")
							}
							.tag(Tab.search)//end of games preview
						//					Text("Personal games").environmentObject(favorites)
						//						.tabItem {
						//							Image(systemName: "gamecontroller.fill")
						//							Text("games")
						//						}
						//						.tag(Tab.personalGames)//end of games preview

						FavoritesListView(selectedTab: $selectedTab).environmentObject(favorites)
							.tabItem {
								Image(systemName: "heart.fill")
								Text("favorites")
							}
							.tag(Tab.favorites)// end of favorites preview

					}
				}

				CustomTabBar(currentTab: $selectedTab).ignoresSafeArea(.all)
			} .ignoresSafeArea(.keyboard)
		}else{

			OfflineFavoritesListView(favorites: favorites).alert(isPresented: $show) {
				Alert(title: Text("Connection Error").bold().font(.largeTitle), message: Text("You dont have internet connection, if you want to use full features of the app connect to the internet connection and retry. While in this mode you can look at your favorite items").font(.title3), dismissButton: .cancel())
			}

		}

	}


}

