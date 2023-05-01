//
//  AppTopPage.swift
//  spot-find
//
//  Created by Yuya Morimoto on R 5/04/22.
//

import ComposableArchitecture
import MapKit
import SwiftUI

struct AppTopPage: View {
    let store: AppStore

    @State private var region = MKCoordinateRegion(
        // サンプルに東京駅の座標指定
        center: CLLocationCoordinate2D(latitude: 35.6809591,
                                       longitude: 139.7673068),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Map(coordinateRegion: $region)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Button("ログアウトする") {
                        viewStore.send(.auth(.signOut))
                    }.buttonStyle(CapsuleButtonStyle(backgroundColor: .Primary, foregroundColor: .PrimaryContrast))
                }.padding()
            }
        }
    }
}
