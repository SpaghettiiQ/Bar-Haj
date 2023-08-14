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
        if #unavailable(macOS 13.0) {
            @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
        }
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
        
        if #available(macOS 13.0, *) {
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

class AppDelegate: NSObject, NSApplicationDelegate {
    @Environment(\.openURL) private var openURL
    
    var statusBarItem : NSStatusItem!
    var statusBarMenu : NSMenu!
    
    var darkMode = false
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        
        self.statusBarItem = statusBar.statusItem(withLength: 30)
        if darkMode {
            self.statusBarItem.button?.image = NSImage(resource: .menuBarIconDark)
        } else {
            self.statusBarItem.button?.image = NSImage(resource: .menuBarIcon)
        }
        
        self.statusBarMenu = NSMenu()
        self.statusBarMenu.addItem(withTitle: "Toggle Dark", action: #selector(toggleDark), keyEquivalent: "1")
        self.statusBarMenu.addItem(withTitle: "GitHub", action: #selector(openGithub), keyEquivalent: "2")
        self.statusBarMenu.addItem(withTitle: "Quit", action: #selector(NSApplication.shared.terminate), keyEquivalent: "q")
        
        self.statusBarItem.menu = self.statusBarMenu
    }
    
    @objc func toggleDark() {
        darkMode.toggle()
        if darkMode {
            self.statusBarItem.button?.image = NSImage(resource: .menuBarIconDark)
        } else {
            self.statusBarItem.button?.image = NSImage(resource: .menuBarIcon)
        }
    }
    
    @objc func openGithub() {
        if let url = URL(string: "https://github.com/SpaghettiiQ/Bar-Haj") {
            openURL(url)
        }
    }
}
