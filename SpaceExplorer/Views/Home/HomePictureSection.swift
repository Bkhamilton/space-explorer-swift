import SwiftUI

struct HomePictureSection: View {
    let picture: SpacePicture
    var body: some View {
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
}
