// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftMessages
import SwiftUI

public enum WarmerUI {
    
    @MainActor
    public static func alert(for message: String) {
        let view = MessageHostingView(id: UUID().uuidString, content: Message(message: message))
        SwiftMessages.show(view: view)
    }
    
    @MainActor
    public static func dismiss() {
        SwiftMessages.hideAll()
    }
}

struct Message: View {
    
    var message: String
    
    var body: some View {
        ZStack {
            Color.pink.opacity(70)
            Text(message)
        }
        .frame(height: 100)
        .clipShape(.rect(cornerRadius: 15))
        .padding(.all, 15)
    }
}
