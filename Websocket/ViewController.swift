//
//  ViewController.swift
//  Websocket
//
//  Created by Nitin Bhatia on 30/08/19.
//  Copyright © 2019 Nitin Bhatia. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController,WebSocketDelegate,WebSocketPongDelegate {
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var txtConversionArea: UITextView!
    var count = 1
    var socket = WebSocket(url: URL(string: "wss://connect.websocket.in/hack4mer_in?room_id=1998")!)

    deinit {
        socket.disconnect(forceTimeout: 0)
        socket.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("welcome")
        socket.delegate = self
        socket.connect()
        socket.pongDelegate = self
       
    }
    
    
    @IBAction func btnSendMessage(_ sender: Any) {
        //socket.write(string: "Hello \(count)")
        //count += 1
        
        txtConversionArea.text += "\n Sent: " + txtMessage.text!
        socket.write(string:txtMessage.text!)
        txtMessage.text = ""
    }
    
    func websocketDidReceivePong(socket: WebSocketClient, data: Data?) {
        print("i m pong data")
        print(data)
    }
    
    func pingTheServer(){
        socket.write(data: Data())
    }

    func websocketDidConnect(socket: WebSocketClient) {
        print("connected")
        socket.write(string: "hello")
        pingTheServer()
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("bye bye")
        print(error?.localizedDescription)
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("i m string")
        print(text)
        let string = "\nRecevied: " + text
        txtConversionArea.text += string
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("i m data")
        print(data)
    }
    
   
}

