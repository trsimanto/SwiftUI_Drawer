//
//  ContentView.swift
//  SwiftUI_Drawer
//
//  Created by Towhid on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomePage: View {
    @Binding var x: CGFloat
    var body: some View{
        VStack{
            HStack{
                Button(action: {
                    withAnimation{
                        x = 0
                    }
                }, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.system(size: 24))
                        .foregroundColor(Color("twitter"))
                })
                
                Spacer(minLength: 0)
                Text("Twitter")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            Spacer()
        }
        .contentShape(Rectangle())
        .background(Color.white)
    }
}

struct Home: View {
    @State var width = UIScreen.main.bounds.width - 90
    // to hide screen
    @State var x = -UIScreen.main.bounds.width + 90
    var body: some View{
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
            
            HomePage(x: $x)
            
            SlideMenu()
                .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                .offset(x: x)
                .background(Color.black.opacity(x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical))
                .onTapGesture {
                    withAnimation{
                        x = -width
                    }
                }
        }
        // adding gesture or drag feature...
        .gesture(DragGesture().onChanged({ (value) in
            print(value.translation.width)
            withAnimation{
                if value.translation.width > 0{
                    if x < 0 {
                        x = -width + value.translation.width
                    }
                } else {
                    x = value.translation.width
                }
            }
        }).onEnded({ (value) in
            withAnimation{
                if -x < width / 2{
                    x = 0
                } else {
                    x = -width
                }
            }
        }))
    }
}


struct SlideMenu: View{
    
    @State private var show = true
    
    var body: some View{
        HStack(spacing: 0){
            VStack(alignment: .leading){
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .center)
                    .clipShape(Circle())
                
                HStack(alignment: .top, spacing: 12){
                    VStack(alignment: .leading, spacing: 12){
                        Text("Intelli Global")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("@_OctaEdges")
                            .foregroundColor(.gray)
                        
                        //Follow Counts ...
                        HStack(spacing: 20){
                            FollowView(count: 8, title: "Following")
                                .onTapGesture {
                                    
                                }
                            
                            FollowView(count: 108, title: "Following")
                                .onTapGesture {
                                    // do something here ...
                                }
                        }
                        .padding(.top, 10)
                        
                        Divider()
                            .padding(.top)
                    }

                    Spacer(minLength: 0)
                    
                    Button(action: {}){
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color("twitter"))
                    }
                }
                
                //Differnt view when up or down buttons pressed...
                
                VStack(alignment: .leading){
                    //Menu buttons ...
                    ForEach(menuButtons, id: \.self){ menu in
                        
                        Button(action: {
                            
                        }, label: {
                            MenuButton(title: menu)
                        })
                        
                    }
                    
                    Divider()
                        .padding(.top, 10)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, UIScreen.main.bounds.height > 750 ? 50 : 30)
            .padding(.bottom, UIScreen.main.bounds.height > 750 ? 50 : 30)
            //default width ...
            .frame(width: UIScreen.main.bounds.width - 90)
            .background(Color.white)
            .ignoresSafeArea(.all, edges: .vertical)
            
            Spacer(minLength: 0)
        }
       // .background(Color.black.opacity(0.5)).ignoresSafeArea(.all, edges: .vertical)
    }
}


struct FollowView: View {
    
    var count: Int
    var title: String
    
    var body: some View{
        HStack(spacing: 10){
            Text("\(count)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

var menuButtons = ["Profile", "Lists", "Topics", "Bookmarks", "Moments"]

struct MenuButton: View {
    var title: String
    
    var body: some View {
        
        HStack (spacing: 15){
            Image(systemName: "person.crop.circle")
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
            .foregroundColor(.gray)
            
            Text(title)
                .foregroundColor(.black)
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
        
    }
}
