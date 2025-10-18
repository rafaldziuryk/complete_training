from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import random
import os
from typing import Dict

app = FastAPI(title="Number Facts API", version="1.0.0")

# Add CORS middleware for Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your Flutter app's domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Model for response
class NumberFact(BaseModel):
    number: int
    text: str

# Dictionary with facts for numbers 1-100
NUMBER_FACTS: Dict[int, str] = {
    1: "1 is the only number that is neither prime nor composite.",
    2: "2 is the smallest and only even prime number.",
    3: "3 is the smallest odd prime number and the number of sides in a triangle.",
    4: "4 is the smallest composite number and the number of sides in a square.",
    5: "5 is the number of fingers on one hand and the number of sides in a pentagon.",
    6: "6 is the smallest perfect number (sum of its proper divisors: 1+2+3=6).",
    7: "7 is considered a lucky number in many cultures and is the number of days in a week.",
    8: "8 is the first cube number (2³) and the number of legs on a spider.",
    9: "9 is the largest single-digit number and the number of innings in baseball.",
    10: "10 is the base of our number system and the number of fingers on both hands.",
    11: "11 is a palindromic prime number.",
    12: "12 is the smallest number with 6 divisors and the number of months in a year.",
    13: "13 is considered unlucky in many cultures but is a prime number.",
    14: "14 is the number of days in two weeks.",
    15: "15 is the number of players on a rugby team.",
    16: "16 is the only number that can be written as 2^4 and 4^2.",
    17: "17 is a prime number and the number of syllables in a haiku.",
    18: "18 is the legal voting age in many countries.",
    19: "19 is a prime number and the number of years in the Metonic cycle.",
    20: "20 is the number of amino acids that make up proteins.",
    21: "21 is the legal drinking age in the US and the number of spots on a standard die.",
    22: "22 is the number of letters in the Hebrew alphabet.",
    23: "23 is a prime number and the number of pairs of chromosomes in humans.",
    24: "24 is the number of hours in a day and the number of carats in pure gold.",
    25: "25 is the number of cents in a quarter and 5 squared.",
    26: "26 is the number of letters in the English alphabet.",
    27: "27 is 3 cubed and the number of bones in a human hand.",
    28: "28 is the second perfect number (1+2+4+7+14=28).",
    29: "29 is a prime number and the number of days in February in a leap year.",
    30: "30 is the number of days in April, June, September, and November.",
    31: "31 is a prime number and the number of days in January, March, May, July, August, October, and December.",
    32: "32 is 2^5 and the number of teeth in an adult human.",
    33: "33 is the number of vertebrae in the human spine.",
    34: "34 is the number of the Fibonacci sequence (after 21 and before 55).",
    35: "35 is the number of countries in the Americas.",
    36: "36 is 6 squared and the number of inches in a yard.",
    37: "37 is a prime number and the normal human body temperature in Celsius.",
    38: "38 is the number of countries in Europe.",
    39: "39 is the number of books in the Old Testament.",
    40: "40 is the number of days and nights it rained during Noah's flood.",
    41: "41 is a prime number and the number of shots in a standard bottle of whiskey.",
    42: "42 is the answer to the ultimate question of life, the universe, and everything (Hitchhiker's Guide).",
    43: "43 is a prime number and the number of US presidents when George W. Bush was elected.",
    44: "44 is the number of US presidents as of 2021.",
    45: "45 is the number of minutes in three-quarters of an hour.",
    46: "46 is the number of human chromosomes.",
    47: "47 is a prime number and the number of Ronin in the famous Japanese tale.",
    48: "48 is the number of hours in two days.",
    49: "49 is 7 squared and the number of US states (including DC).",
    50: "50 is the number of states in the US and the number of cents in half a dollar.",
    51: "51 is the number of cards in a deck (including jokers).",
    52: "52 is the number of weeks in a year and the number of cards in a standard deck.",
    53: "53 is a prime number and the number of cards in a deck with one joker.",
    54: "54 is the number of cards in a deck with two jokers.",
    55: "55 is a Fibonacci number and the number of mph speed limit on many US highways.",
    56: "56 is the number of counties in Montana.",
    57: "57 is the number of varieties of Heinz ketchup.",
    58: "58 is the number of counties in California.",
    59: "59 is a prime number and the number of seconds in a minute (minus 1).",
    60: "60 is the number of seconds in a minute and minutes in an hour.",
    61: "61 is a prime number and the number of counties in New York.",
    62: "62 is the number of counties in New York state.",
    63: "63 is the number of squares on a chessboard (8x8 minus 1 for the king).",
    64: "64 is 8 squared and the number of squares on a chessboard.",
    65: "65 is the traditional retirement age in many countries.",
    66: "66 is the number of books in the Bible.",
    67: "67 is a prime number and the number of counties in Alabama.",
    68: "68 is the number of counties in Pennsylvania.",
    69: "69 is the number of counties in Tennessee.",
    70: "70 is the number of years in a traditional lifespan (biblical).",
    71: "71 is a prime number and the number of counties in Texas.",
    72: "72 is the number of hours in three days.",
    73: "73 is a prime number and the number of books in the Catholic Bible.",
    74: "74 is the number of counties in Kentucky.",
    75: "75 is the number of years in three-quarters of a century.",
    76: "76 is the number of counties in Arkansas.",
    77: "77 is the number of counties in Oklahoma.",
    78: "78 is the number of cards in a tarot deck.",
    79: "79 is a prime number and the atomic number of gold.",
    80: "80 is the number of years in four score (Lincoln's Gettysburg Address).",
    81: "81 is 9 squared and the number of squares in a 9x9 Sudoku grid.",
    82: "82 is the number of counties in Mississippi.",
    83: "83 is a prime number and the number of counties in Michigan.",
    84: "84 is the number of counties in Indiana.",
    85: "85 is the number of counties in Minnesota.",
    86: "86 is the number of counties in Missouri.",
    87: "87 is the number of counties in Kansas.",
    88: "88 is the number of keys on a piano and the number of counties in Ohio.",
    89: "89 is a prime number and a Fibonacci number.",
    90: "90 is the number of degrees in a right angle and the number of minutes in an hour and a half.",
    91: "91 is the number of counties in Tennessee.",
    92: "92 is the atomic number of uranium.",
    93: "93 is the number of counties in Nebraska.",
    94: "94 is the number of counties in Iowa.",
    95: "95 is the number of counties in Tennessee.",
    96: "96 is the number of counties in Illinois.",
    97: "97 is a prime number and the number of counties in North Carolina.",
    98: "98 is the number of counties in South Carolina.",
    99: "99 is the number of counties in Iowa.",
    100: "100 is a perfect square (10²) and the number of years in a century."
}

@app.get("/")
async def root():
    return {"message": "Number Facts API", "endpoints": ["/random", "/exact/{number}"]}

@app.get("/random", response_model=NumberFact)
async def get_random_fact():
    """Get a random fact about a number between 1 and 100."""
    number = random.randint(1, 100)
    fact = NUMBER_FACTS[number]
    return NumberFact(number=number, text=fact)

@app.get("/exact/{number}", response_model=NumberFact)
async def get_exact_fact(number: int):
    """Get a fact about a specific number between 1 and 100."""
    if number < 1 or number > 100:
        raise HTTPException(
            status_code=400, 
            detail="Number must be between 1 and 100"
        )
    
    fact = NUMBER_FACTS[number]
    return NumberFact(number=number, text=fact)

if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)
