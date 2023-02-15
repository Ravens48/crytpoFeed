//
//  AsyncImage.swift
//  CryptoFeed
//
//  Created by Thomas ravens on 03/02/2023.
//

import SwiftUI

struct ImageFromUrl: View {
    let urlImage:String
    let width: Int?
    let height: Int?
    var body: some View {
        AsyncImage(url: URL(string: urlImage), content: { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .scaledToFit()
                    .frame(width: CGFloat(width ?? 32), height: CGFloat(height ?? 32))
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                Image(systemName: "bitcoinsign.circle.fill")
                // Since the AsyncImagePhase enum isn't frozen,
                // we need to add this currently unused fallback
                // to handle any new cases that might be added
                // in the future:
            }
        })
    }
}
