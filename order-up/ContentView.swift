//
//  ContentView.swift
//  order-up
//
//  Created by YJ Soon on 14/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var milo = 0
    @State private var teh = 0
    @State private var toast = 0
    @State private var showOrderSheet = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Order Up")
                .font(.largeTitle)
                .bold()

            Text("Kopitiam snacks. Tap + to add.")
                .font(.title3)
                .foregroundStyle(.secondary)

            SnackRow(emoji: "🥤", name: "Milo", price: "$1.50", color: Color.orange.opacity(0.18), count: $milo)

            SnackRow(emoji: "🍵", name: "Teh", price: "$1.20", color: Color.brown.opacity(0.15), count: $teh)

            SnackRow(emoji: "🍞", name: "Kaya Toast", price: "$2.00", color: Color.yellow.opacity(0.22), count: $toast)

            Text("Total  $\(Double(milo) * 1.5 + Double(teh) * 1.2 + Double(toast) * 2.0, specifier: "%.2f")")
                .font(.title)
                .bold()
                .padding(.top, 8)

            Button("Place Order") {
                showOrderSheet = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .font(.title2)
        }
        .padding(20)
        .sheet(isPresented: $showOrderSheet) {
            DismissSheet()
        }
    }
}

#Preview {
    ContentView()
}

struct DismissSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Text("Order Placed!")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.red)

            Button("Go back") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .font(.title2)
        }
    }
}

struct SnackRow: View {
    let emoji: String
    let name: String
    let price: String
    let color: Color
    @Binding var count: Int

    var body: some View {
        HStack {
            Text("\(emoji)  \(name)")
                .font(.title2)
            Text(price)
                .foregroundStyle(.secondary)
            Spacer()
            Text("\(count)")
                .font(.title)
                .monospacedDigit()
            Button {
                count -= 1
                if count < 0 { count = 0 }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.largeTitle)
            }
            Button {
                count += 1
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
            }
        }
        .padding()
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
