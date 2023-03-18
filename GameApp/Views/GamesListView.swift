//
//  GamesListView.swift
//  GameApp
//
//  Created by Luka Mavrin on 02.12.2022..
//

import Foundation
import SwiftUI
import MapKit
struct GamesListView: View {

	@EnvironmentObject var games: GamesApi
	@EnvironmentObject var favorites: Favorites
	@Binding var selectedTab: Tab
	var gridLayout: [GridItem] {
		if UIDevice.current.userInterfaceIdiom == .pad{
			return [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible()), GridItem(.flexible())]
		}
		return [GridItem(.flexible()), GridItem(.flexible())]
	}
	var backgroundColor = [Color("backgroundColor1"),Color("backgroundColor2")]
	@State var animate = false
	@State var animate2 = false
	

	var body: some View {
		NavigationStack {
			VStack {
				if games.list.isEmpty {
					ProgressView()
				} else {
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
								LazyVGrid(columns: gridLayout) {
									ForEach(games.list) { gm in
										NavigationLink( destination: GameDetailsView(game: gm, selectedTab: $selectedTab)) {
											//TODO: mage a game row
											GameCard(game: gm)
										}
										//nav link
									}
								}
								Spacer().padding(.bottom,100)
							}.navigationTitle("Popular Titles")

					}.background(
						LinearGradient(colors: backgroundColor, startPoint: .bottom, endPoint: .top)
					)
				}
			}
		}.accentColor(Color.black)
	}
}
