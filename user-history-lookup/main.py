import requests
import json
import os

os.system("title ROBLOX USER HISTORY LOOKUP / github.com/democratico")
os.system("cls")

def menu(lol):
    if lol==True:
        os.system("cls")
    print("""
██╗░░░██╗░██████╗███████╗██████╗░  ██╗░░██╗██╗░██████╗████████╗░█████╗░██████╗░██╗░░░██╗
██║░░░██║██╔════╝██╔════╝██╔══██╗  ██║░░██║██║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚██╗░██╔╝
██║░░░██║╚█████╗░█████╗░░██████╔╝  ███████║██║╚█████╗░░░░██║░░░██║░░██║██████╔╝░╚████╔╝░
██║░░░██║░╚═══██╗██╔══╝░░██╔══██╗  ██╔══██║██║░╚═══██╗░░░██║░░░██║░░██║██╔══██╗░░╚██╔╝░░
╚██████╔╝██████╔╝███████╗██║░░██║  ██║░░██║██║██████╔╝░░░██║░░░╚█████╔╝██║░░██║░░░██║░░░
░╚═════╝░╚═════╝░╚══════╝╚═╝░░╚═╝  ╚═╝░░╚═╝╚═╝╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░

██╗░░░░░░█████╗░░█████╗░██╗░░██╗██╗░░░██╗██████╗░
██║░░░░░██╔══██╗██╔══██╗██║░██╔╝██║░░░██║██╔══██╗
██║░░░░░██║░░██║██║░░██║█████═╝░██║░░░██║██████╔╝
██║░░░░░██║░░██║██║░░██║██╔═██╗░██║░░░██║██╔═══╝░
███████╗╚█████╔╝╚█████╔╝██║░╚██╗╚██████╔╝██║░░░░░
╚══════╝░╚════╝░░╚════╝░╚═╝░░╚═╝░╚═════╝░╚═╝░░░░░

    => Made by github.com/democratico
          [1] -> Lookup
          [2] -> What's an UserID
          [3] -> Exit

""")
    option = int(input("Option: "))
    if option==1:
        get()
    elif option == 2:
        example()
    elif option == 3:
        os.system("cls")
        os.system("exit")

def example():
    os.system("cls")
    print("""
Hey, I'll teach you how to get your target's UserID:
    1. Go to your target's ROBLOX profile.
    2. Look at the link, should look like this: https://www.roblox.com/users/1/profile
    3. Now, copy the number digits of the link, should be this with the example above: 1
    4. Done! You have your target's UserID now.
          
""")
    input("Press ENTER to go back to the menu...")
    menu(True)

def get():
    os.system("cls")
    id = str(input("Target UserID: "))
    url = f"https://users.roblox.com/v1/users/{id}/username-history?limit=100&sortOrder=Asc"
    r = requests.get(url)

    if r.status_code == 200:
        info = json.loads(r.text)
 
        data_array = info["data"]
        current_path = os.getcwd()
        with open(f"{current_path}\{id}.txt","w") as f:
            for item in data_array:
                f.write(f"{item['name']}\n")
            f.close()
            print(f"Username history has been saved in {current_path}\{id}.txt")
            input("Press ENTER to exit...")
    elif r.status_code == 400:
        print("Invalid User ID! Please retry again.\n")
        menu(False)

menu(False)
