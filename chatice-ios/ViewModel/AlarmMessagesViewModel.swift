//
//  AlarmMessagesViewModel.swift
//  chatice-ios
//
//  Created by admin on 2/26/22.
//

import Foundation

class AlarmMessagesViewModel: ObservableObject {
    @Published var alarmMessage = []
    
    func loadAlarmMessages() {
        
    }
    func sendAlarMessage() {
        
    }
}

struct AlarmMessageViewModel {
    //let sender
    //let destination
    var type: [Bool] = [true, false, false, false, false] //["○○중!", "가는중!", "자는중!", "공부중!", "운동중!"]
    let sendTime = Date()
    
    var startTime = Date()
    var endTime = Date()
    
    var locationAllow: [String : Bool] = ["now-start" : false, "start-end" : false, "end-oneHour" : false]
    
    var alarmTime: [String : Bool] = ["start-5" : false, "start" : false, "end-5" : false, "end" : false, "end+10" : false, "end+20" : false, "end+30" : false, "end+40" : false, "end+50" : false, "end+60" : false]
    
    var detailContent: String = ""
}
