//
//  AgreeViewController.swift
//  Mohaeng
//
//  Created by 김승찬 on 2021/11/04.
//

import UIKit
import WebKit

class AgreeViewController: UIViewController {

    // MARK: - Properties
    enum Agree: Int {
        case service = 0, personal = 1, eula = 2
    }
    
    var agree: Agree?
    var destinationURL: [String] = ["https://brawny-pest-02a.notion.site/70443cf71de6456a918e03e7ebdea4ba", "https://brawny-pest-02a.notion.site/6fca114a154e49e2b81d1a53ddf56fe1", "https://brawny-pest-02a.notion.site/EULA-d4fe8eb52f8b44e99d9b7cf3c50ee541"]
  
    // MARK: - @IBOutlet Properties
    @IBOutlet var webView: WKWebView!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        divideViewControllerCase()
    
    }
    
    // MARK: - Functions
    func divideViewControllerCase() {
        switch agree {
        case .service:
            openWebPage(to: destinationURL[0])
        case .personal:
            openWebPage(to: destinationURL[1])
        case .eula :
            openWebPage(to: destinationURL[2])
        case .none:
            break
        }
    }
    
    func openWebPage(to urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
