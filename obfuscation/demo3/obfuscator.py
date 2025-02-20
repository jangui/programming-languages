#!/usr/bin/env python3
import argparse


"""
  +[] = 0
  +!+[] = 1
  +!+[]+!+[] = 2
"""

DICT = {
        '0' : '(+[]+"")',
        '1' : '(+!+[]+"")',
        '2' : '(+!+[]+!+[]+"")',
        '3' : '(+!+[]+!+[]+!+[]+"")',
        '4' : '(+!+[]+!+[]+!+[]+!+[]+"")',
        '5' : '(+!+[]+!+[]+!+[]+!+[]+!+[]+"")',
        '6' : '(+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+"")',
        '7' : '(+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+"")',
        '8' : '(+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+"")',
        '8' : '(+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+"")',
        '[' : '([]+{})[+[]]',
        ']' : '([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        '(' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        ')' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        '{' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        '}' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        ' ' : '([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        'a' : '(![]+[])[+!+[]]',
        'b' : '([]+{})[+!+[]+!+[]]',
        'c' : '([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]',
        'd' : '([][_]+[])[+!+[]+!+[]]',
        'e' : '(!![]+[])[+!+[]+!+[]+!+[]]',
        'f' : '(![]+[])[+[]]',
        'g' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        'h' : '(((+!+[]+!+[])+((+!+[]+!+[])))*((+!+[]+!+[]))*((+!+[]+!+[]))+(+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]+!+[]+!+[]))',
        'i' : '([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]',
        'j' : '([]+{})[+!+[]+!+[]+!+[]]',
        'k' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[]))',
        'l' : '(![]+[])[!+[]+!+[]]',
        'm' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+(!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[]))',
        'n' : '([][_]+[])[+!+[]]',
        'o' : '([]+{})[+!+[]]',
        'p' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+(+!+[]+!+[]+!+[]+!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[]))',
        'q' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+(+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[]))',
        'r' : '(!![]+[])[+!+[]]',
        's' : '(![]+[])[!+[]+!+[]+!+[]]',
        't' : '(!![]+[])[+[]]',
        'u' : '(!![]+[])[+!+[]+!+[]]',
        'v' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        'w' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]+!+[]+!+[]))',
        'x' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]+!+[]+!+[]))',
        'y' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]+!+[]+!+[]))',
        'z' : '(((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]+!+[]))[(!![]+[])[+[]]+([]+{})[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+([][_]+[])[+!+[]+!+[]+!+[]+!+[]+!+[]]+([][_]+[])[+!+[]]+([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]](((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])*(+!+[]+!+[])+((+!+[]+!+[])*(+!+[]+!+[])+!+[])*(+!+[]+!+[])+(!+[]+!+[]+!+[]+!+[]+!+[]+!+[]))',
        'O' : '([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        'S' : '([]+([]+[])[([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+([]+{})[+!+[]]+([][_]+[])[+!+[]]+(![]+[])[!+[]+!+[]+!+[]]+(!![]+[])[+[]]+(!![]+[])[+!+[]]+(!![]+[])[+!+[]+!+[]]+([]+{})[+!+[]+!+[]+!+[]+!+[]+!+[]]+(!![]+[])[+[]]+([]+{})[+!+[]]+(!![]+[])[+!+[]]])[+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]+!+[]]',
        }

def make_callable(to_call):
    cons = ''
    for char in "constructor":
        cons += DICT[char] + "+"
    cons = cons[:-1]
    return "[][" + cons + "][" + cons + "](" + to_call + ")()"

def obfuscate(js, s):
    output = ''
    for char in js:
        if char in DICT.keys():
            output += DICT[char] + "+"
        else:
            output += '"'+char+'"' + "+"

    if s == None:
        return make_callable(output[:-1])
    return output[:-1]

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('js', type=str)
    parser.add_argument('-s')
    args = parser.parse_args()

    obs_js = obfuscate(args.js, args.s)
    print(obs_js)

if __name__ == "__main__":
    main()

