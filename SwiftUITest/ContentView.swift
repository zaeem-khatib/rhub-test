import SwiftUI

enum LoginState {
    case loggedOut
    case loggedIn
    case cancelled
}

struct ContentView: View {
    
    @State private var loginState: LoginState = .loggedOut
    @State private var showAlert = false
    @State private var dialogMessage = ""

    var body: some View {
        if loginState == .loggedOut {
            LoginView(loginState: $loginState, showAlert: $showAlert, alertMessage: $dialogMessage)
        } else {
            DialogView(message: dialogMessage)
        }
    }
}

#Preview {
    ContentView()
}
