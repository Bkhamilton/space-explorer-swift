import SwiftUI
import Combine

struct SpaceLaunchView: View {
    let launches = SpaceLaunch.sampleData
    @State private var searchText = ""
    @State private var searchSubject = PassthroughSubject<String, Never>()
    @State private var debouncedSearchText = ""
    @State private var cancellables = Set<AnyCancellable>()
    
    var filteredLaunches: [SpaceLaunch] {
        if debouncedSearchText.isEmpty {
            return launches
        } else {
            return launches.filter { launch in
                launch.name.localizedCaseInsensitiveContains(debouncedSearchText) ||
                launch.agency.localizedCaseInsensitiveContains(debouncedSearchText) ||
                launch.missionType.localizedCaseInsensitiveContains(debouncedSearchText) ||
                launch.location.localizedCaseInsensitiveContains(debouncedSearchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredLaunches) { launch in
                NavigationLink(destination: SpaceLaunchDetailView(launch: launch)) {
                    SpaceLaunchCard(launch: launch)
                }
            }
            .searchable(text: $searchText, prompt: "Search launches")
            .onChange(of: searchText) { newValue in
                searchSubject.send(newValue)
            }
            .navigationTitle("Space Launches")
        }
        .onAppear {
            setupDebouncing()
        }
    }
    
    private func setupDebouncing() {
        searchSubject
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { searchValue in
                debouncedSearchText = searchValue
            }
            .store(in: &cancellables)
    }
    
    private func statusColor(for status: String) -> Color {
        switch status {
        case "Scheduled":
            return .blue
        case "Launched":
            return .green
        default:
            return .gray
        }
    }
}

#Preview {
    SpaceLaunchView()
}