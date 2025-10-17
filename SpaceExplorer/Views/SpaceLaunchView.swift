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
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(launch.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(launch.status)
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(statusColor(for: launch.status))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    HStack {
                        Label(launch.agency, systemImage: "building.2")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    HStack(spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Label("Date", systemImage: "calendar")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(launch.launchDate)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Label("Type", systemImage: "tag")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(launch.missionType)
                                .font(.subheadline)
                        }
                    }
                    
                    HStack {
                        Label(launch.location, systemImage: "location.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            .searchable(text: $searchText, prompt: "Search launches")
            .onChange(of: searchText) { oldValue, newValue in
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