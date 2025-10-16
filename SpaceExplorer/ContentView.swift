import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "photo.fill")
                }
            
            MarsView()
                .tabItem {
                    Label("Mars", systemImage: "globe")
                }
            
            SpaceLaunchView()
                .tabItem {
                    Label("Space Launch", systemImage: "rocket.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
