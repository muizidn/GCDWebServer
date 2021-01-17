//
//  ViewController.swift
//  JustExampleSwift
//
//  Created by Muis on 16/01/21.
//

import Cocoa
import WebKit
import GCDWebServers

class ViewController: NSViewController {
  @IBOutlet weak var svelteJS: SvelteJSView!
  @IBOutlet weak var svelteWasmRust: SvelteWasmRustView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    svelteJS.__viewDidLoad()
    svelteWasmRust.__viewDidLoad()
  }
}


final class SvelteJSView: NSView {
  @IBOutlet weak var webView: WKWebView!
  
  func __viewDidLoad() {
    initWebServer()
    guard let req = webServer.serverURL
      .map({ url in
        URLRequest(
          url: url
        )
      })
      else { fatalError() }
    webView.load(req)
  }
  
  private lazy var webServer = GCDWebServer()
  
  func initWebServer() {
    
    var dirPath = ""
    let rootDir = #file[..<#file.lastIndex(of: "/")!]
    dirPath = "\(rootDir)/../svelte-app/public"
    
    webServer.addGETHandler(
      forBasePath: "/",
      directoryPath: dirPath,
      indexFilename: "index.html",
      cacheAge: 0,
      allowRangeRequests: true
    )
    
    webServer.start(withPort: 9090, bonjourName: nil)
    
    print("Visit \(webServer.serverURL!) in your web browser")
  }
}

final class SvelteWasmRustView: NSView {
  @IBOutlet weak var webView: WKWebView!
  
  func __viewDidLoad() {
    initWebServer()
    guard let req = webServer.serverURL
      .map({ url in
        URLRequest(
          url: url
        )
      })
      else { fatalError() }
    webView.load(req)
  }
  
  private lazy var webServer = GCDWebServer()
  
  func initWebServer() {
    
    var dirPath = ""
    let rootDir = #file[..<#file.lastIndex(of: "/")!]
    dirPath = "\(rootDir)/../svelte-wasm/svelte-app/public"
    
    webServer.addGETHandler(
      forBasePath: "/",
      directoryPath: dirPath,
      indexFilename: "index.html",
      cacheAge: 0,
      allowRangeRequests: true
    )
    
    webServer.start(withPort: 9091, bonjourName: nil)
    
    print("Visit \(webServer.serverURL!) in your web browser")
  }
}
