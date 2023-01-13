# imvip on v3rm
# GAME UPDATE CHECKER
# API ENDPOINTS:
# GET PLACE INFO: https://games.roblox.com/v1/games/multiget-place-details?placeIds=
# GET UNIVERSE INFO (MUST USE THING ABOVE TO GET UNIVERSEID): https://games.roblox.com/v1/games?universeIds=

import requests
import json
import time
import os

s = requests.session()

# CONFIGURATION | MUST ADD OR NOTHING WILL WORK #

s.cookies[".ROBLOSECURITY"] = ""
webhookUrl = ""

## DONT TOUCH ANYTHING BELOW UNLESS YOU KNOW WHAT YOU'RE DOING ##

os.system("title Game Update Checker | imvip on v3rm")
os.system("cls")

def add():
    os.system("cls")
    print("""
    How to get place ID:
    -    roblox.com/games/ 292439477 /Phantom-Forces
    -    Copy the numbers that are before Phantom-Forces or the game name, only the number not any /

    Please put a place ID below.
    """)

    gameid = input("user@root:~# ")
    if isinstance(gameid, str) == True:
        print("¿Are you sure you want to add this game? (Y/N): ")
        confirmation = str(input("user@root:~# "))

        if confirmation == "Y":

            r1 = s.get(
                "https://games.roblox.com/v1/games/multiget-place-details?placeIds=z".replace("z", gameid))
            r1 = r1.json()
            r2 = s.get(
                "https://games.roblox.com/v1/games?universeIds=z".replace("z", str(r1[0]['universeId'])))
            r2 = r2.json()

            # placeid-universeid.txt
            f = open("info\c-d.txt".replace("c", gameid).replace("d", str(r1[0]['universeId'])), "w")
            f.write(str(r2['data'][0]['updated']))
            f.close()

            print("Successfully added z".replace("z", gameid))

            print("¿Start checking if game gets updated? (Y/N): ")
            startChecking = str(input("user@root:~# "))

            if startChecking == "Y":
                check(gameid,str(r1[0]['universeId']))
            else:
                os.system("exit")
        else:
            os.system("exit")

def notify(universeInfo):
    readable_updateDate = universeInfo['data'][0]['updated']
    readable_updateDate.replace("T", " ")
    readable_updateDate.replace("Z", "")
    readable_updateDate = readable_updateDate.split(" ") #day | time
    
    if webhookUrl != "":
        data = {
            "content": "🔔||@everyone||"
        }
        data['embeds'] = [
            {
                "title": "A game has updated!",
                "description": "[name](link)".replace("name",universeInfo['data'][0]['name']).replace("link","https://www.roblox.com/games/fuck/".replace("fuck",str(universeInfo['data'][0]['rootPlaceId']))),
                "url": "",
                "color": 14869218,
                "timestamp": readable_updateDate[0],
                "footer": {
                "icon_url": "",
                "text": "imvip on v3rm"
                }
            }
        ]
        whSend = requests.post(webhookUrl, json=data, headers={"User-Agent":"my bot 0.1"})
        if whSend.status_code == 200:
            print("Successfully sent a message to the Discord webhook URL.")

    print(universeInfo['data'][0]['name'],"https://www.roblox.com/games/fuck/".replace("fuck",str(universeInfo['data'][0]['rootPlaceId'])), f"Updated at: {readable_updateDate[0]}")

def check(gameid, universeId):
    os.system("cls")
    updateDate = open("info\c-d.txt".replace("c", gameid).replace("d", universeId), "r")
    oldUpdateData = updateDate.read()
    latestUpdateDate = updateDate.read()
    updateDate.close()

    while True:
        r3 = s.get("https://games.roblox.com/v1/games?universeIds=z".replace("z", universeId))
        r3 = r3.json()
        if latestUpdateDate != r3['data'][0]['updated']:
            latestUpdateDate = r3['data'][0]['updated']
            oldUpdateData = latestUpdateDate
            updateDate = open("info\c-d.txt".replace("c", gameid).replace("d", universeId), "w")
            updateDate.write(r3['data'][0]['updated'])
            updateDate.close()
            notify(r3)
        else:
            print("Game has not updated.")
        time.sleep(10)  # Checks every 10 minutes if the game has update

def check2():
    os.system("cls")
    print("""
    WARNING: The game you are about to check must be added already or else the console will throw an error.

    To start checking you must go to the info folder and copy the file name and paste it below. (without the .txt at the end) (Right click to paste file name)
    """)

    filename = str(input("user@root:~# "))
    parts = filename.split("-")
    check(parts[0],parts[1])

def menu():
    print("""
    Welcome to the Game Update Checker, this took me some time to make (because i had to find API and stuff)
    so i would appreciate if u leave atleast a vouch on the thread :)

    -> i hope this is useful for yall hub/ware/script owners/makers/developers

    WARNING: 
    1.Make sure you added a ROBLOX cookie, the ROBLOX API only allows authorized users,
    it can be an empty or new account, doesn't matter.
    2.Make sure you added a Discord webhook URL in the code, when a game updates it will send a message to the webhook and let everyone know the game has updated! :)

    Cmds:
    [1] - Add game (Must not be added already, if so, please run the check cmd)
    [2] - Check updates on game (Must be added already or else it will throw an error.)
    [3] - Exit console

    Please enter a command below.
    """)

    option = str(input("user@root:~# "))

    if option == "1":
        add()
    
    if option == "2":
        check2()

    if option == "3":
        os.system("exit")

menu()
