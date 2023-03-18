//
//  GameAppApp.swift
//  GameApp
//
//  Created by Luka Mavrin on 01.12.2022..
//

import SwiftUI

@main
struct GameAppApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var games = GamesApi()
	@StateObject var favorites = Favorites()
    var body: some Scene {
			WindowGroup {
				ContentView().environmentObject(games).environmentObject(favorites).onAppear {
					UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
					AppDelegate.orientationLock = .portrait
				}
			}
    }
}
