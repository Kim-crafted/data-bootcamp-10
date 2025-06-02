#Create Chatbot for ordering Pizza

##Create menu
piz <- c("Margherita Pizza", "Pepperoni Pizza", "Vegetarian Delight", "BBQ Chicken Pizza", "Four Cheese Pizza")
dri <- c("Coke", "Diet Coke", "Lemonade", "Iced Tea", "Sparkling Water")
piz_price <- c(12.99, 14.49, 15.99, 16.49, 15.49)
dri_price <- c(2.49, 2.49, 2.99, 2.79, 2.99)

##Turn menu into dataframe
piz_df <-data.frame( ID = 1:length(piz),
                     pizza = piz,
                     price = piz_price
)
dri_df <-data.frame( ID = 1:length(dri),
                     drinks = dri,
                     price = dri_price
)


##Create function for ordering
order <- function() {
  repeat {
    ##Display the menu
    print("Hi there! Welcome to Pizza Passion Bistro. Here is our pizza menu: ")
    piz_inputs <- integer()
    piz_amounts <- integer()
    repeat {
      print(piz_df) 
      piz_input <- as.integer(readline("Enter Pizza ID: "))
      piz_amount <- as.integer(readline("Amount: "))
      if (!piz_input %in% piz_df$ID) {
        print("Please enter the valid ID")
      } else {
        piz_inputs <- c(piz_inputs, piz_input)
        piz_amounts <- c(piz_amounts, piz_amount)
        more_piz <- tolower(readline("Do you want to order more pizza?(Yes/No): "))
        if (more_piz != "yes") {
              break
        }
      }
    }
    
    print("Here's our drink menu: ")
    dri_inputs <- integer()
    dri_amounts <- integer()
    repeat {
      print(dri_df)
      dri_input <- as.integer(readline("Enter Drink ID: "))
      dri_amount<- as.integer(readline("Amount: "))
      if (!dri_input %in% dri_df$ID) {
        print("Please enter the valid ID")
      } else {
        dri_inputs <- c(dri_inputs, dri_input)
        dri_amounts <- c(dri_amounts, dri_amount)
        more_dri <- tolower(readline("Do you want to order more drink?(Yes/No): "))
        if (more_dri != "yes") {
              break
        }
      }
    }
    
    ##Display customer bill
    print("Here's the bill: ")
    item <- c(piz_df$pizza[piz_inputs], 
              dri_df$drinks[dri_inputs])
    price <-c(piz_df$price[piz_inputs], 
              dri_df$price[dri_inputs])
    amount <- c(piz_amounts, dri_amounts)
    total <- price*amount
    bill_df <- data.frame(item, price, amount, total)
    total <- sum(total)
    print(bill_df)
    cat("_____________________________________", "\n", "Total: ", total)
    
    
    reorder <- tolower(readline("Do you want to order anything else (Yes/No): "))
    if (reorder != "yes") {
      print("Thank you for dining with us")
      break
    }
  }
}


order()
