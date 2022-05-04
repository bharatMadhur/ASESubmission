//
//  HomePage.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 4/11/22.
//

import SwiftUI
import Marquee


struct HomePage: View {

    @State var shouldShowLogOutOptions = false
//    @StateObject var isRecoverPassword = false
    @ObservedObject private var vm = Mainview()
    
    private var customNavBar: some View {
            HStack() {
                Image(systemName: "person.fill")
                    .font(.system(size: 24, weight: .heavy))

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(vm.Email)")
                        .font(.system(size: 14, weight: .bold))

                }
                Spacer()
                Button {
                    shouldShowLogOutOptions.toggle()
                } label: {
                    Image(systemName: "power")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(.label))
                }
            }
            .padding()
            .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Signout"), message: Text("Do You Want To SignOut?"), buttons: [
                    .destructive(Text("Sign Out"), action: {
                        print("handle sign out")
                        vm.handlesignout()
                    }),
                        .cancel()
                ])
            }.fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil ){
                LoginPage(didcompletedLoginProcess: {
                    self.vm.isUserCurrentlyLoggedOut = false
                    self.vm.fetchCurrentuser()
                })
//                .environmentObject(isRecoverPassword)
            }
        
        }
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading,spacing: nil){
                customNavBar
                
                        TabView{
                            StockListView().tabItem{
                                Label("Stocks", systemImage: "chart.xyaxis.line")
                            }
                         
                            stockSearchView()
                                .tabItem{
                                    Label("Search", systemImage: "magnifyingglass")
                                        .foregroundColor(Color.red)
                                }
                            
                            topNewsView()
                                .tabItem {
                                    Label("Top News", systemImage: "newspaper.fill")
                                }
                            
                            Settings().tabItem{
                                Label("Settings",systemImage: "gear")
                                
                                }
                        }

                    }
            .navigationTitle("NYSCSCREENER").navigationBarTitleDisplayMode(.inline)

        }
            }


}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomePage()
            HomePage()
            HomePage()
            HomePage()
            HomePage()
        }
            
    }
}
