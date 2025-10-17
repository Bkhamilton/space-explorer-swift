import SwiftUI

struct HomeView: View {
    @State private var _pictures: [SpacePicture] = SpacePicture.sampleData
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    // Public accessor for testing
    var pictures: [SpacePicture] {
        return _pictures
    }
    
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
                
                List(_pictures) { picture in
                    HomePictureSection(picture: picture)
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
                    _pictures = apodResponses.map { SpacePicture(from: $0) }
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
