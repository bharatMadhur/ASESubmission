//
//  MainView.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/2/22.
//
//
//import SwiftUI
//
//struct MainView: View {
//    
//    @State var shouldShowLogOutOptions = false
//    
//    @ObservedObject private var vm = Mainview()
//    
//    private var customNavBar: some View {
//            HStack() {
//                Image(systemName: "person.fill")
//                    .font(.system(size: 24, weight: .heavy))
//
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("\(vm.Email)")
//                        .font(.system(size: 14, weight: .bold))
//
//                    HStack {
//                        Circle()
//                            .foregroundColor(.green)
//                            .frame(width: 8, height: 14)
//                        Text("online")
//                            .font(.system(size: 8))
//                            .foregroundColor(Color(.lightGray))
//                    }
//
//                }
//                Spacer()
//                Button {
//                    shouldShowLogOutOptions.toggle()
//                } label: {
//                    Image(systemName: "power")
//                        .font(.system(size: 16, weight: .bold))
//                        .foregroundColor(Color(.label))
//                }
//            }
//            .padding()
//            .actionSheet(isPresented: $shouldShowLogOutOptions) {
//                .init(title: Text("Signout"), message: Text("Do You Want To SignOut?"), buttons: [
//                    .destructive(Text("Sign Out"), action: {
//                        print("handle sign out")
//                        vm.handlesignout()
//                    }),
//                        .cancel()
//                ])
//            }.fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil ){
//                LoginPage(didcompletedLoginProcess: {
//                    self.vm.isUserCurrentlyLoggedOut = false
//                    self.vm.fetchCurrentuser()
//                })
//            }
//        
//        }
//    
//    
//    var body: some View {
//        NavigationView {
//            VStack{
//                customNavBar
//                        StockListView()
//                            
//                        }
//
//                    }.navigationTitle("NYSCSCREENER")
//
//        }
//}
//
//
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
