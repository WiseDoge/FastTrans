//
//  Home.swift
//  FastTrans
//
//  Created by Ray on 2020/12/17.
//

import SwiftUI
import Alamofire

struct Home: View {
    @State private var apikey: String = ""
    @State private var source: String = ""
    @State private var target: String = ""
    @State private var log: String = ""
    private let showQuit: Bool
    
    init(_ showQuit: Bool) {
        self.showQuit = showQuit
    }
    
    func update(obj: Any) -> Void {
        let jsonObj = obj as! [String: String]
        if let tgt_text = jsonObj["tgt_text"] {
            target = tgt_text
            log = ""
        }else{
            if let errorMsg = jsonObj["error_msg"]{
                log = errorMsg
            }else{
                log = "Error"
            }
            
        }
        
    }
    
    func failure() -> Void {
        log = "Network Error"
    }
    
    func swapSrcAndTgt() -> Void {
        let tmp = source
        source = target
        target = tmp
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("API Key")
                TextField("API Key", text:$apikey)
            }
            TextEditor(text:$source).frame(height:80)
            HStack{
                Button("汉译英"){
                    requestAPI(from: "zh", to: "en", apikey: apikey, srcText: source, successAct: update, failureAct: failure)
                }
                Button(action: swapSrcAndTgt){
                    Image(systemName: "arrow.up.and.down")
                }
                Button("英译汉"){
                    requestAPI(from: "en", to: "zh", apikey: apikey, srcText: source, successAct: update, failureAct: failure)
                }
                if showQuit{
                    Button("Quit"){
                        exit(0)
                    }
                }
            }
            TextEditor(text: $target).frame(height:200)
            Text(log)
        }.padding().frame(width: 330, height: 400, alignment: .top)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(false)
    }
}
