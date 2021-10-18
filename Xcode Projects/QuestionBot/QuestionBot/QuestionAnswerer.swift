struct MyQuestionAnswerer {
    func responseTo(question: String) -> String {
        // TODO: Write a response
        // return "?"
        
        
        let lowerQuestion = question.lowercased()
        if lowerQuestion.hasPrefix("hello") {
            return "Why, hello there"
        }
        if lowerQuestion == "where are the cookies?" {
            return "In the cookie jar!"
        } else if lowerQuestion.hasPrefix("where") {
            return "To the North!"
        } else if question.hasPrefix("who"){
            return "Santa Clause"
        } else if question.hasPrefix("what"){
            return "your favourite restaurant"
        } else if question.hasPrefix("why"){
            return "for the greater wellness of humanity"
        }
        
        // default answer
        else {
          
            let defaultNumber = question.count % 3
            
            if defaultNumber == 0 {
                return "That really depends"
            } else if defaultNumber == 1{
                return "I don't really know that"
            }
            else {
                return "Ask me again tomorrow"
            }

        }
        
        
    }
}
