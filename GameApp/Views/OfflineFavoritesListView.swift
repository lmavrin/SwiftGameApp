//
//  FavoritesListView.swift
//  GameApp
//
//  Created by Luka Mavrin on 02.12.2022..
//

import Foundation
import SwiftUI
import MapKit
struct OfflineFavoritesListView: View {
	@State var favorites: Favorites
	@State var gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
	var backgroundColor = [Color("backgroundColor1"),Color("backgroundColor2")]
	@State var animate = false
	@State var animate2 = false
	var int = 0;
	var body: some View {
		NavigationStack {
			VStack {
				if favorites.favoriteGames.isEmpty {
					Text("There are no favorites")
				} else {
					ZStack {
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
							LazyVGrid(columns: gridLayout) {
								ForEach(favorites.favoriteGames) { gm in
									NavigationLink( destination: GameDetailsView(game: gm, selectedTab: .constant(.favorites))) {
										//TODO: mage a game row
										GameCard(game: gm)
									}//nav link
								}
							}.navigationBarTitle("Favorites")
							Spacer().padding(.bottom,100)
						}
					}.background(
						LinearGradient(colors: backgroundColor, startPoint: .bottom, endPoint: .top)
					)
				}

			}
			
		}.accentColor(.black)
	}

}

