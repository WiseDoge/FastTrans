//
//  WebAPI.swift
//  FastTrans
//
//  Created by Ray on 2020/12/17.
//

import Foundation
import Alamofire

struct InputInfo: Encodable {
    let from: String
    let to: String
    let apikey: String
    let src_text: String
}

func requestAPI(from: String, to: String, apikey: String, srcText: String, successAct: @escaping (Any) -> Void, failureAct: @escaping () -> Void) {
    let info = InputInfo(from: from, to: to, apikey: apikey, src_text: srcText)
    let url = "https://free.niutrans.com/NiuTransServer/translation"
    AF.request(url,
               method: .post,
               parameters: info,
               encoder: JSONParameterEncoder.default).responseJSON { response in
        switch response.result{
            case let.success(value):
                successAct(value)
            case .failure(_):
                failureAct()
        }
    }
}
