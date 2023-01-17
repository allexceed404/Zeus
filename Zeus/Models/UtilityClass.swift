//
//  UtilityClass.swift
//  Zeus
//
//  Created by Priyanshu Verma on 10/01/23.
//

class UtilityClass {
    static let newsBaseURL = "https://newsapi.org/v2/"
    
    enum APIEndpoint: String {
        case headlines = "top-headlines"
        case everything = "everything"
        case sources = "top-headlines/sources"
    }
    
    enum FilterType {
        case category
        case source
    }
    
    enum Category: String, CaseIterable {
        case business = "business"
        case entertainment = "entertainment"
        case general = "general"
        case health = "health"
        case science = "science"
        case sports = "sports"
        case technology = "technology"
    }
    
    static let countryCodeDict: [String:String] = ["United States":"us", "India":"in", "United Arab Emirates":"ae", "Argentina":"ar", "Austria":"at", "Australia":"au", "Belgium":"be", "Bulgaria":"bg", "Brazil":"br", "Canada":"ca", "Switzerland":"ch", "China":"cn", "Colombia":"co", "Cuba":"cu", "Czechia":"cz", "Germany":"de", "Egypt":"eg", "France":"fr", "United Kingdom":"gb", "Greece":"gr", "Hong Kong":"hk", "Hungary":"hu", "Indonesia":"id", "Ireland":"ie", "Israel":"il", "Italy":"it", "Japan":"jp", "Korea":"kr", "Lithuania":"lt", "Latvia":"lv", "Morocco":"ma", "Mexico":"mx", "Malaysia":"my", "Nigeria":"ng", "Netherlands":"nl", "Norway":"no", "New Zealand":"nz", "Philippines":"ph", "Poland":"pl", "Portugal":"pt", "Romania":"ro", "Serbia":"rs", "Russia":"ru", "Saudi Arabia":"sa", "Sweden":"se", "Singapore":"sg", "Slovenia":"si", "Slovakia":"sk", "Thailand":"th", "Turkey":"tr", "Taiwan":"tw", "Ukraine":"ua", "Venezuela":"ve", "South Africa":"za",
        "यूनाइटेड स्टेट्‍स": "us", "भारत": "in", "संयुक्त अरब अमीरात": "ae", "अर्जेंटीना": "ar", "ऑस्ट्रिया": "at", "ऑस्ट्रेलिया": "au", "बेल्जियम": "be", "बुल्गारिया": "bg", "ब्राज़ील": "br"
   ]
}
