//
//  BarHajApp.swift
//  BarHaj
//
//  Created by SpaghettiiQ on 25.07.2023.
//

import SwiftUI

@main
struct BarHajApp: App {
    
    init() {
        load()
    }
    
    @Environment(\.openURL) private var openURL
//    @State var isOn: Bool = false
    @State var isOn: Bool = true
//    @State var imageName: String = "MenuBarIcon"
    
    let defaults = UserDefaults.standard
    
    var body: some Scene {
        let binding = Binding {
            isOn
        } set: {_ in
            save()
        }
        
        MenuBarExtra(
            "Blåhaj", image: isOn ? "MenuBarIcon-Dark" : "MenuBarIcon")
        {
            Toggle(isOn: binding) {
                Text("Dark Mode")
            }.keyboardShortcut("1")
            
            Button("GitHub") {
                if let url = URL(string: "https://github.com/SpaghettiiQ/Bar-Haj") {
                    openURL(url)
                }
            }.keyboardShortcut("2")
            
            Divider()
            
            Button("Bye Blåhaj") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("q")
        }
        
    }

    func save() {
        isOn.toggle()
        if isOn == true {
//            imageName = "MenuBarIcon-Dark"
            defaults.setValue(true, forKey: "darkOn")
        } else {
//            imageName = "MenuBarIcon"
            defaults.setValue(false, forKey: "darkOn")
        }
        print(defaults.bool(forKey: "darkOn"))
        print(isOn)
    }

    func load() {
        let darkOn = defaults.bool(forKey: "darkOn")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            print("a")
            isOn = true
            print(isOn)
            print(darkOn)
        })
    }
}
