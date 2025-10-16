import SwiftUI

struct HomeView: View {
    @State private var pictures: [SpacePicture] = SpacePicture.sampleData
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading space pictures...")
                        .padding()
                }
                
                if let error = errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                        .onTapGesture {
                            loadAPODData()
                        }
                }
                
                List(pictures) { picture in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: picture.imageName)
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading) {
                                Text(picture.title)
                                    .font(.headline)
                                Text(picture.date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Text(picture.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }
                    .padding(.vertical, 8)
                }
                .navigationTitle("Space Pictures")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: loadAPODData) {
                            Image(systemName: "arrow.clockwise")
                        }
                        .disabled(isLoading)
                    }
                }
            }
        }
        .onAppear {
            loadAPODData()
        }
    }
    
    private func loadAPODData() {
        isLoading = true
        errorMessage = nil
        
        APODService.shared.fetchMultipleAPODs(count: 5) { result in
            DispatchQueue.main.async {
                isLoading = false
                
                switch result {
                case .success(let apodResponses):
                    pictures = apodResponses.map { SpacePicture(from: $0) }
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    // Keep sample data on error
                    print("Failed to load APOD data: \(error)")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
