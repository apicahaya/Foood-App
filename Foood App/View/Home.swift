//
//  Home.swift
//  Foood App
//
//  Created by Agni Muhammad on 15/03/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    @State private var offset: CGFloat = 200.0
    
    var body: some View {
        
        
        ZStack {
            VStack(spacing: 10){
                HStack(spacing: 15){
                    
                    Button(action: {
                        withAnimation(.easeIn) {HomeModel.showMenu.toggle()}
                    }, label: {
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color("pink"))
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating...." : "Deliver To")
                        .foregroundColor(.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("pink"))
                    
                    Spacer(minLength: 0)
                    
                }
                .padding([.horizontal, .top])
                
                Divider()
                
                HStack(spacing: 15) {

                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Search...", text: $HomeModel.search)
                    
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Divider()
                
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    VStack(spacing: 40) {
                        
                        ForEach(HomeModel.filtered) { item in
                            
                            // item view
                            
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                
                                ItemView(item: item)
                                
                                HStack {
                                    
                                    Text("FREE DELIVERY")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(Color("pink"))
                                    
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {}, label: {
                                        
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color("pink"))
                                            .clipShape(Circle())
                                    })
                                }
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                            })
                                .frame(width: UIScreen.main.bounds.width - 30)
                        }
                        
                    }
                    .padding(.top, 10)
                })
            }
            
            // side menu.
            
            HStack{
                Menu(homeData: HomeModel)
                // move effect from left
                    .offset(x: HomeModel.showMenu ? 0: -UIScreen.main.bounds.width / 1.6)
                
                Spacer(minLength: 0)
                
            }
            .background(
                Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                    .onTapGesture(perform: {
                        withAnimation(.easeIn) {HomeModel.showMenu.toggle()}
                    })
            )
            
            // Non closable alert if permission denied
            
            if HomeModel.noLocation{
                
                Text("Please enable Location Access In Setting to further move on!")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
                
            }
        }
        .onAppear(perform: {
            
            // calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
            
        })
        
        .onChange(of: HomeModel.search) { value in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                
                if value == HomeModel.search && HomeModel.search != "" {
                    
                    // search data...
                    
                    HomeModel.filteredData()
                    
                }
            }
            
            if HomeModel.search == ""{
                // reset all data
                
                withAnimation(.linear){HomeModel.filtered = HomeModel.items}
            }
        }
    }
}

