import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject private var handler = TendiesHandler()
    @State private var isImporting = false
    
    // Define the custom file type
    // Fallback to strict identifier, but prefer filename extension matching
    let tendiesType = UTType(filenameExtension: "tendies") ?? UTType(exportedAs: "com.posta.tendies")
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "iphone.gen3")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding(.top, 50)
            
            Text("Posta")
                .font(.largeTitle)
                .bold()
            
            Text("Install .tendies wallpapers")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            if handler.isProcessing {
                VStack {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                    Text("Installing...")
                        .font(.caption)
                }
            } else {
                Button(action: {
                    isImporting = true
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Select .tendies File")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220)
                    .background(Color.blue)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                
                Button(action: {
                    if let url = URL(string: "App-Prefs:root=Wallpaper") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Open Wallpaper Settings")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)
            }
            
            Spacer()
            
            Text(handler.statusMessage)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.gray)
                .frame(height: 100)
        }
        .padding()
        .fileImporter(
            isPresented: $isImporting,
            allowedContentTypes: [tendiesType, .data, .content], // Allow broad types to fix selection issues
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                guard let url = urls.first else { return }
                handler.installTendies(from: url)
            case .failure(let error):
                handler.statusMessage = "Import failed: \(error.localizedDescription)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
