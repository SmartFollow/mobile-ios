//
//  Conversation.swift
//  client-ipad
//
//  Created by Alexandre Page on 16/11/2017.
//  Copyright © 2017 Alexandre Page. All rights reserved.
//

import UIKit

class Conversation: NSObject {
  let id: Int
  let creatorId: Int
  let subject: String
  let participants: [Participant]
  var messages = [Message]()
  
  init(id: Int, creatorId: Int, subject: String, participants: [Participant]) {
    self.id = id
    self.creatorId = creatorId
    self.subject = subject
    self.participants = participants
  }
  
  func getParticipantsName() -> [String] {
    var array: [String] = []
    let userId = UserDefaults.standard.value(forKey: "id")! as! Int
    
    for participant in participants {
      if participant.id != userId {
        array.append(participant.firstName)
      }
    }
    return array
  }
  
  func sortMessageByDate() {
    self.messages = self.messages.sorted(by: { $0.date < $1.date })
  }
  
  static func isMessageFromUser(message: Message) -> Bool {
    let userId = UserDefaults.standard.value(forKey: "id")! as! Int
    return message.creatorId == userId
  }
  
  static func doesUsersMatchParticipants(conversation: Conversation, users: [User]) -> Bool {
    for user in users {
      if isUserInParticipants(participants: conversation.participants, user: user) == false {
        return false
      }
    }
    return true
  }
  
  static func getConversation(conversations: [Conversation], users: [User]) -> Conversation? {
    for conversation in conversations {
      if doesUsersMatchParticipants(conversation: conversation, users: users) {
        return conversation
      }
    }
    return nil
  }
  
  func getParticipantAvatar(message: Message) -> UIImage? {
    for participant in participants {
      if participant.id == message.creatorId {
        return participant.picture
      }
    }
    return nil
  }
  
  private
  
  static func isUserParticipant(participant: Participant, user: User) -> Bool {
    return participant.id == user.id
  }
  
  static func isUserInParticipants(participants: [Participant], user: User) -> Bool {
    for participant in participants {
      if isUserParticipant(participant: participant, user: user) {
        return true
      }
    }
    return false
  }
  
  
}
