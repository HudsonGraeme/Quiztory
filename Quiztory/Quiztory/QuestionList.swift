//
//  QuestionList.swift
//  Quiztory
//
//  Created by D. graham on 2018-06-01.
//  Copyright © 2018 Carspotter Daily. All rights reserved.
//

import UIKit
func populateQuestions() {
    questions = [
        Question(Question: "What has Tesla Motors contributed to Canada?", Answers: [("Sustainable energy generation for Ontario", false), ("Fossil fuel vehicles", false), ("Wearable technology", false), ("Green vehicles and power storage options", true)]),
        Question("When was Bill C-16 passed?", [("June 19, 2017", true), ("June 15, 2016", false), ("July 5, 2017", false), ("Never", false)]),
        Question("Bill C-16 compels Canadians to use what when referring to a person?", [("Mr. Or Mrs.", false), ("Gender pronouns", true), ("Their name", false), ("Fam", false)]),
        Question("When was Amazon Prime introduced in Canada?", [("December 21 2012", false), ("May 13 2005", false), ("August 6 1995", false), ("January 8 2013", true)]),
        Question("How much did Amazon Prime charge per year?", [("$20", false), ("Nothing, it was free", false), ("$79", true), ("$100", false)]),
        Question("What does MCRF stand for?", [("Myoko Crisis Relish Fund", false), ("Myanmar Car Release Form", false), ("Myanmar Crisis Relief Fund", true), ("Manchester City Runs FIFA", false)]),
        Question("Who are the Arakan Rohingya Salvation Army?", [("A terrorist organization", true), ("An army sent to help Myanmar", false), ("A thrift store company", false), ("Myanmar's official army", false)]),
        Question("Canada has dedicated _______ over 3 years to address the Myanmar situation.", [("$30 million", false), ("$300 million", true), ("$3 million", false), ("$100 million", false)]),
        Question("Justin Trudeau appointed a gender balanced cabinet of ___ men and ___ women.", [("5, 7", false), ("10, 10", false), ("15, 15", true), ("12, 10", false)]),
        Question("Starting 2018-19, what does the new Parental Sharing system do?", [("Allows parents to have the same wage", false), ("Allows parents to equally share their children", false), ("Allows both parents equal leave time to care for children", true), ("It’s just cool", false)]),
        Question("Every year technology advances ______ it's previous year.", [("Double", true), ("Triple", false), ("Half", false), ("Quadruple", false)]),
        Question("Which bill did Idle No More protest ?", [("Bill C-45", true), ("Bill C-16", false), ("Bill C-36", false), ("Bill C-47", false)]),
        Question("Drake has won _____ awards from _____ nominations.", [("444, 96", false), ("67, 967", false), ("96, 444", true), ("21, 200", false)]),
        Question("What is Drake's real name?", [("Kendrick Duckworth ", false), ("Nayvadius DeMun Wilburn", false), ("Abel Tesfaye", false), ("Aubrey Graham", true)]),
        Question("Where did the Idle No More movement start, and how did it start?", [("In Ontario, by stories of the protest spreading around on Snapchat", false), ("In Saskatchewan, started with a hashtag spreading around Facebook and Twitter.", true), ("In Quebec, it started when people whispered \"Idle No More\" in each others ears", false), ("Idk, I didn't listen", false)]),
        Question("How do companies try to improve their phone's looks over the years?", [("All of the below", true), ("Have a higher screen to body ratio", false), ("Make bigger screens", false), ("Make it the edges more curved", false)]),
            
        Question("Who is drake beefing right now?", [ ("Lil pump", false), ("J. Cole", false), ("A$AP Rockey", false), ("Pusha T.", true)])
    ]
}
