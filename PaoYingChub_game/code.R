game <- function() {

    hands <- c("Com choose: hammer", "Com choose: scissor", "Com choose: paper")

    flush.console()
    username <- readline("What's your name ma friend: ")
    print(paste("Hello!", username, "Welcome to the game😀"))
    print("Let's GO!!!🤝")

    user_hands <- readline("Which one do you choose: ")
    com_hands <- sample(hands, 1)

    if (user_hands == "hammer" & com_hands == "Com choose: hammer") {
        print(com_hands)
        return("Draw")
    } else if (user_hands == "hammer" & com_hands == "Com choose: scissor") {
        print(com_hands)
        return("You Win👍🏻")
    } else if (user_hands == "hammer" & com_hands == "Com choose: paper") {
        print(com_hands)
        return("You Lose👻")
    } else if (user_hands == "scissor" & com_hands == "Com choose: scissor") {
        print(com_hands)
        return("Draw")
    } else if (user_hands == "scissor" & com_hands == "Com choose: hammer") {
        print(com_hands)
        return("You Lose👻")
    } else if (user_hands == "scissor" & com_hands == "Com choose: paper") {
        print(com_hands)
        return("You Win👍🏻")
    } else if (user_hands == "paper" & com_hands == "Com choose: paper") {
        print(com_hands)
        return("Draw")
    } else if (user_hands == "paper" & com_hands == "Com choose: scissor") {
        print(com_hands)
        return("You Lose👻")
    } else if (user_hands == "paper" & com_hands == "Com choose: hammer") {
        print(com_hands)
        return("You Win👍🏻")
    } else {
        print("BYE😜")
    }

 }


game()
