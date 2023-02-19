//
//  TextHtml.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import SwiftUI
import WebKit

struct TextHtml: UIViewRepresentable {
    let htmlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

extension StringProtocol {
    func htmlToAttributedString() throws -> AttributedString {
        try .init(
            .init(
                data: .init(utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        )
    }
}

extension Text {
    init(html: String, alert: String? = nil) {
        do {
            try self.init(html.htmlToAttributedString())
        } catch {
            self.init(alert ?? error.localizedDescription)
        }
    }
}
