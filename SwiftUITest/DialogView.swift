import SwiftUI

struct DialogView: View {
    
    var message: String
    
    var body: some View {
        Text(message)
    }
}

#Preview {
    DialogView(message: "Hello! World.")
}
