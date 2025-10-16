import SwiftUI

struct HomeView: View {
    let pictures = SpacePicture.sampleData
    
    var body: some View {
        NavigationView {
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
        }
    }
}

#Preview {
    HomeView()
}
