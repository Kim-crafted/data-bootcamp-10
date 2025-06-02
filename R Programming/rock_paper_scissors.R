
##Rock Paper Scissors Game
hands<-c("rock", "paper", "scissors")
comp_score <- 0
user_score <- 0

#Write function

game <- function () {
  print("Let's roll")
  while (user_score < 5) {
    comp_hand <- sample(hands, 1)
    user_hand <- tolower(readline("choose your hand (Rock/ Paper/ Scissor): "))
    if (user_hand == "quit") {
      break
    }
    
    #if user win
    if ((user_hand == "rock" & comp_hand == "scissors") |
        (user_hand == "scissors" & comp_hand == "paper") |
        (user_hand == "paper" & comp_hand == "rock")) {
      user_score <- user_score + 1
    }
    #if comp win
    if ((comp_hand == "rock" & user_hand == "scissors") | 
        (comp_hand == "scissors" & user_hand == "paper") |
        (comp_hand == "paper" & user_hand == "rock")) {
      comp_score <- comp_score + 1
      
      #if draw
    } else if (user_hand == comp_hand) {
      print("Draw")
    }
    
    #display score
    cat("user:", user_score, "computer: ", comp_score)
    
    if (user_score == 5) {
      print ("You win") 
      break
    }  else if (comp_score == 5) {
      print("You lose!")
      break
    }
    
    
    
  }
  
}


game()
