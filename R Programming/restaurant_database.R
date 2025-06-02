
library(RSQLite)

#Create data frame
#Branches
branches_df <-data.frame(
  branch_id = 1:2,
  branch_name = c("BKK", "HTY"),
  phone = c("089-550-0551", "089-550-0552")
)

#Staff
staffs_df <- data.frame(
  staff_id = 1:10,
  staff_name = c("Aom", "Ko", "Bee", "Nat", "Ton", "Jay", "Kaew", "Tai", "Chon", "Mod"),
  branch_id = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2),
  position = c("Manager", "Chef", "Chef", "Waitstaff", "Waitstaff", "Manager", "Chef", "Waitstaff", "Chef", "Waitstaff"),
  salary = c( 35000, 25000, 25000, 20000, 20000, 35000, 25000, 20000, 25000, 20000 )
  
)

#Customer
customers_df <- data.frame(
  customer_id = 1:20,
  customer_names = c("Anan", "Bodin", "Chai", "Dao", "Ek", 
                     "Fah", "Gao", "Hana", "Ice", "Jai", 
                     "Korn", "Lek", "Mew", "Nok", "Oat", 
                     "Pong", "Qin", "Rao", "Siam", "Tao"),
  phone_numbers = c(
    "+66 81-2345678", "+66 82-3456789", "+66 83-4567890", 
    "+66 84-5678901", "+66 85-6789012", "+66 86-7890123", 
    "+66 87-8901234", "+66 88-9012345", "+66 89-0123456", 
    "+66 2-3456789", "+66 90-1234567", "+66 91-2345678", 
    "+66 92-3456789","+66 93-4567890", "+66 94-5678901", 
    "+66 95-6789012","+66 96-7890123", "+66 97-8901234", 
    "+66 98-9012345","+66 2-4567890")
  
)

#Menu
menus_df <- data.frame(
  menu_id = 1:10,
  menu_name = c(
    "Cheeseburger", "Chicken Nuggets", "French Fries", "Hot Dog","Chicken Sandwich", 
    "Fish Sandwich", "Soda", "Iced Tea", "Milkshake", "Lemonade"),
  menu_types = c(
    "Food", "Food", "Food", "Food", "Food",
    "Food", "Beverage", "Beverage", "Beverage", "Beverage"),
  menu_prices = c(5.99, 4.49, 2.99, 3.49, 6.99,                    
                  6.99, 1.99, 2.49, 3.49, 2.99)
)

#Order
orders_df <- data.frame(
  order_id = 1:20,
  customer_id = 1:20,
  staff_id = c(8, 8, 5, 4, 10, 5, 8, 10, 4, 8, 5, 4, 10, 5, 8, 4, 10, 8, 5, 4),
  order_date = c(
    "2024-09-01", "2024-09-01", "2024-09-01", "2024-09-01", "2024-09-01",
    "2024-09-01", "2024-09-01", "2024-09-01", "2024-09-01", "2024-09-02",
    "2024-09-02", "2024-09-02", "2024-09-02", "2024-09-02", "2024-09-02",
    "2024-09-02", "2024-09-02", "2024-09-02", "2024-09-02", "2024-09-02"),
  total_price = c(7.98, 5.98, 9.47, 6.48, 9.98, 8.48, 6.98, 8.98, 5.98, 9.48, 7.48, 9.48, 8.98, 8.47, 6.48, 8.48, 11.46, 8.98, 5.48, 5.98)
  
  
) 
#Create connect
con <- dbConnect(SQLite(), "restaurant.db")



#write table into DB
dbWriteTable(con, "branches", branches_df)
dbWriteTable(con, "customers", customers_df)
dbWriteTable(con, "staffs", staffs_df)
dbWriteTable(con, "menus", menus_df)
dbWriteTable(con, "orders", orders_df)

#Get Data
df1 <- dbGetQuery(con, 
                  "SELECT 
                    customers.customer_names AS name,
                    orders.total_price AS total_spend
                  FROM customers
                  JOIN orders ON customers.customer_id = orders.customer_id
                  ORDER BY 2 DESC
                  LIMIT 5")

df1

dbDisconnect(con)
