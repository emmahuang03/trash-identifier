//
//  CompletionsResult.swift
//  WAiSTE
//
//  Created by Airei Fukuzawa on 7/8/23.
//
import Foundation
import OpenAI

struct CompletionsResult: Codable, Equatable {
    
    public struct Choice: Codable, Equatable {
        public let text: String
        public let index: Int
    }

    public struct Usage: Codable, Equatable {
        public let promptTokens: Int
        public let completionTokens: Int
        public let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    public let usage: Usage
}
