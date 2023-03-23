import SwiftUI
import Replicate

// Get your API token at https://replicate.com/account
private let client = Replicate.Client(token: <#token#>)
#warning(
"""
Don't put secrets in code or any other resources bundled with your app.
Instead, fetch them from CloudKit or another server and store them in the keychain.

See:
• https://developer.apple.com/documentation/cloudkit/ckdatabase/1449126-fetch
• https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_keychain
"""
)

// https://replicate.com/stability-ai/stable-diffusion
enum StableDiffusion: Predictable {
    static var modelID = "stability-ai/stable-diffusion"
    static let versionID = "db21e45d3f7023abc2a46ee38a23973f6dce16bb082a930b0c49861f96d1e5bf"

    struct Input: Codable {
        let prompt: String
    }

    typealias Output = [URL]
}

struct ContentView: View {
    @State private var prompt = ""
    @State private var prediction: StableDiffusion.Prediction? = nil
    
    var body: some View {
        Form {
            Section {
                TextField(text: $prompt,
                          prompt: Text("Enter a prompt to display an image"),
                          axis: .vertical,
                          label: {})
                    .disabled(prediction?.status.terminated == false)
                    .submitLabel(.go)
                    .onSubmit(of: .text) {
                        Task {
                            try! await generate()
                        }
                    }
            }
            
            if let prediction {
                ZStack {
                    Color.clear
                        .aspectRatio(1.0, contentMode: .fit)
                    
                    switch prediction.status {
                    case .starting, .processing:
                        VStack{
                            ProgressView("Generating...")
                                .padding(32)
                            
                            Button("Cancel") {
                                Task { try await cancel() }
                            }
                        }
                    case .failed:
                        Text(prediction.error?.localizedDescription ?? "Unknown error")
                            .foregroundColor(.red)
                    case .succeeded:
                        if let url = prediction.output?.first {
                            VStack {
                                AsyncImage(url: url, scale: 2.0, content: { phase in
                                    phase.image?
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(32)
                                })
                                
                                ShareLink("Export", item: url)
                                    .padding(32)

                            }
                        }
                    case .canceled:
                        Text("The prediction was canceled")
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding()
                .listRowBackground(Color.clear)
                .listRowInsets(.init())
            }
        }
        
        Spacer()
    }
    
    func generate() async throws {
        prediction = try await StableDiffusion.predict(with: client,
                                                       input: .init(prompt: prompt))
        try await prediction?.wait(with: client)
    }
    
    func cancel() async throws {
        try await prediction?.cancel(with: client)
    }
}
