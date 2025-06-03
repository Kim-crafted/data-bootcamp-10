from random import choice

def pao_ying_chub():
    print("Alright, let's roll!")
    user_score = 0
    com_score = 0

    while True:
        #user's hand
        user_hand = ['rock', 'paper', 'scissor']
        print("Please show your hand: [rock, paper, scissor]")
        user_hand = input('Your hand: ').strip().lower()

        #computer's hand
        com_hand = choice(['rock', 'paper', 'scissor'])
        print(f"Computer hand: {com_hand}")

        #if user win
        if user_hand == com_hand:
            print("Draw!")
        elif user_hand == 'rock' and com_hand == 'scissor':
            print("You win!")
            user_score += 1
        elif user_hand == 'paper' and com_hand == 'rock':
            print("You win!")
            user_score += 1
        elif user_hand == 'scissor' and com_hand == 'paper':
            print("You win!")
            user_score += 1

        #if computer win
        elif com_hand == 'rock' and user_hand == 'scissor':
            print("You Lose!")
            com_score += 1
        elif com_hand == 'paper' and user_hand == 'rock':
            print("You Lose!")
            com_score += 1
        elif com_hand == 'scissor' and user_hand == 'paper':
            print("You Lose!")
            com_score += 1

        #Ask user if they want to play another round
        play_again = input("Another round?(yes/no): ").strip().lower()
        if play_again == 'yes':
            print("------------")
            continue
        else:
            print("Thanks for playing, here's a score!")
            print(f"Your score: {user_score}")
            print(f"Computer score: {com_score}")
            break


pao_ying_chub()
