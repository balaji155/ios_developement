//
//  DetailViewController.swift
//  project7
//
//  Created by balaji.papisetty on 06/11/25.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var petition: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let petition = petition else { return }
        
        let html = """
          <html>
            <head>
              <meta name="viewport" content="width=device-width, initial-scale=1">   
               <style>
                     body {
                        font-size: 150%
                    }
               </style> 
           </head>
          <body>
            \(petition.body)
          </body>
        <html>
      """
        webView.loadHTMLString(html, baseURL: nil)

}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
