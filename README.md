# Battleships tech test

Today, you'll practice doing a tech test.

For most tech tests, you'll essentially have unlimited time.  For this one, there will be a light time pressure.  See what you can get done in four hours.

You'll get to practice your OO design and TDD skills.

You'll work alone, and you'll also review your own code so you can practice reflecting on and improving your own work.

## User stories
### Key
Methods : **
Values : --
ordered in priority.

```
As a player
So that I can play a more interesting game
I would like to have a -range of ship sizes to choose from-
```
ship.size
```
As a player
So that I can create a layout of ships to outwit my opponent
I would like to be able to choose the -directions my ships face in-
```
ship.direction: Bool
- true = north facing
- false = east facing
```
As a player
So that I can prepare for the game
I would like to *place a -ship- in a board location*
```
location = "2A"
placeShip(ship: Ship, location: String)
```
As a player
So that I can have a coherent game
I would like *ships to be constrained to be on the board*
```
checkPlacement()
- place inside of placeShip
```
As a player
So that I can have a coherent game
I would like *ships to be constrained not to overlap*
```
- should be dealt with in checkPlacement()
- maybe seperated
```
As a player
So the game is more fun to play
I would like a nice *command line interface that lets me enter ship positions and shots using commands (rather than using IRB to interact with objects)*
```
- have lots of print statements
```
As a player
So that I can win the game
I would like to be able to *fire at my opponent's board*
```
fire(location)
- when game starts
```
As a player
So that I can refine my strategy
I would like to *know when I have sunk an opponent's ship*
```
print("Ship sunk \(ship.name)")
```
As a player
So that I know when to finish playing
I would like to *know when I have won or lost*
```
- game ends
print("who won")
```
As a player
So that I can consider my next shot
I would like to be *able to see my hits and misses so far*
```
fireLog: [String]
- could be intergrated into ships, maybe board should be the ultimate array/ class
```
As a player
So that I can play against a human opponent
I would like to *play a two-player game*
```
- replace computer choice with human, game initializer
