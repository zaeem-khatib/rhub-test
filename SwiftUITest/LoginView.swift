import SwiftUI
import SwiftUIX

struct LoginView: View {
    
    @Binding var loginState: LoginState
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    @State private var username = ""
    @State private var password = ""
    @State private var showCancelConfirmation = false
    
    var body: some View {
        GeometryReader { geometry in
            
            let controlsWidth = geometry.size.width / 2 * 1.2
            
            NavigationView {
                VStack {
                    HStack {
                        Text("Use Name:")
                            .frame(alignment: .leading)
                            .padding(.trailing, 10)
                        TextField("", text: $username)
                            .frame(width: controlsWidth)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .submitLabel(.done)
                    }
                    .padding()

                    HStack {
                        Text("Password:")
                            .frame(alignment: .leading)
                            .padding(.trailing, 10)
                        SecureField("", text: $password)
                            .frame(width: controlsWidth)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .submitLabel(.done)
                    }
                    .padding()

                    HStack() {
                        Button(action: login) {
                            Text("Login")
                                .foregroundColor(Color.black)
                                .padding()
                                .frame(width: controlsWidth)
                                .background(Color.white)
                                .border(Color.black)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding(.trailing, 30)
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    
                    HStack() {
                        
                        Button(action: {
                            endEditing()
                            showCancelConfirmation = true
                        }) {
                            Text("Cancel")
                                .foregroundColor(Color.black)
                                .padding()
                                .frame(width: controlsWidth)
                                .background(Color.white)
                                .border(Color.black)
                        }
                        .alert(isPresented: $showCancelConfirmation) {
                            Alert(
                                title: Text(""),
                                message: Text("Are you sure you want to cancel sign in?"),
                                primaryButton: .default(Text("Yes")) {
                                    alertMessage = "Goodbye!"
                                    loginState = .cancelled
                                },
                                secondaryButton: .cancel(Text("No"))
                            )
                        }
                        .padding()
                        
                            }
                    .padding(.trailing, 15)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
    }

    func login() {
        endEditing()
        if username.isEmpty || password.isEmpty {
            showAlert = true
            alertMessage = "Please enter both username and password."
        } else {
            loginState = .loggedIn
            alertMessage = "Welcome to RHUB!"
        }
    }
}

extension View {
    
    func endEditing() {
        Keyboard.dismiss()
    }
}


#Preview {
    LoginView(loginState: .constant(.loggedOut), showAlert: .constant(false), alertMessage: .constant(""))
}
