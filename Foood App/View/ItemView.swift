//
//  ItemView.swift
//  Foood App
//
//  Created by Agni Muhammad on 16/03/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    
    var item: Item
    
    var body: some View {
        
        
        VStack{
            
            // downloading image from web
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
            
            
            HStack(spacing: 8) {
                
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                //Rating view
                
                ForEach(1...5, id: \.self) { index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_ratings) ?? 0 ?
                                         Color("pink") : .gray)
                    
                }
            }
            
            HStack {
                
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
        }
    }
}

