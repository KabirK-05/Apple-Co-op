/*:
## Exercise: Goals

Think of a goal of yours that can be measured in progress every day, whether it’s minutes spent exercising, number of photos sent to friends, hours spent sleeping, or number words written for your novel.

 - callout(Exercise): Create an array literal with 20 to 25 items of sample data for your daily activity. It may be something like `let milesBiked = [3, 7.5, 0, 0, 17 ... ]` Feel free to make up or embellish the numbers, but make sure you have entries that are above, below and exactly at the goal you've thought of. _Hint: Make sure to choose the right kind of array for your data, whether `[Double]` or `[Int]`._
 */
let goal = 10
let videosWatched = [24, 18, 21, 19, 24, 14, 11, 9, 20, 8, 18, 5, 6, 22, 23, 17, 17, 17, 10, 14, 24, 6, 25, 14, 11]

//:  - callout(Exercise): Write a function that takes the daily number as an argument and returns a message as a string. It should return a different message based on how close the number comes to your goal. You can be as ambitious and creative as you'd like with your responses, but make sure to return at least two different messages depending on your daily progress!
func goalDetermine(dailyNumber: Int) -> String{
    if dailyNumber < goal{
        return "Excellent! You exceeded your goal!"
    }
    else if dailyNumber == goal{
        return "Good job you met your goal!"
    }
    else if dailyNumber > goal+3{
        return "You're almost there!"
    }
    else if dailyNumber > goal + 5{
        return "You're getting there!"
    }
    else{
        return "You still need to get your videos lower"
    }
}
//:  - callout(Exercise): Write a `for…in` loop that iterates over your sample data, calls your function to get an appropriate message for each item, and prints the message to the console.
for day in videosWatched{
    print(goalDetermine(dailyNumber: day))
}
/*:
[Previous](@previous)  |  page 16 of 18  |  [Next: Exercise: Screening Messages](@next)
 */
