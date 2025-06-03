class ATM():
    def __init__(self, name, balance, pin):
        self.name = name
        self.balance = balance
        self.pin = pin

    #PIN Verification
    def enter_pin(self, entered_pin):
        if entered_pin == self.pin:
            print("Authentication successful.")
        else:
            print("Incorrect PIN, please try again.")

    #Balane Checking
    def check_balance(self):
        print(f"Your current balance is ${self.balance}")

    #Deposit
    def deposit(self, amount):
        self.balance += amount
        print("Transaction Complete")
        print(f"You current balance is ${self.balance}")

    #Withdrawal
    def withdraw (self, amount):
        if amount <= self.balance:
            self.balance -= amount
            print("Transaction Complete")
            print(f"You current balance is ${self.balance}")
        else:
            print("Insufficient funds.")

    #Change PIN
    def change_pin(self, old_pin, new_pin):
        if old_pin == self.pin:
            self.pin = new_pin
            print("PIN Changed successfully")
        else:
            print("Incorrect old PIN")



user1 = ATM('Kim', 10000, '1234')

user1.enter_pin('1234')
user1.check_balance()
user1.withdraw(1000)
user1.deposit(3000)
user1.balance
user1.change_pin('1234', '4567')
user1.pin

user2 = ATM('Jess', 30000, '2260')
user2.enter_pin('2260')
user2.check_balance()
user2.deposit(3000)
user2.withdraw(3000)
user2.change_pin('2260', '3360')
user2.pin
