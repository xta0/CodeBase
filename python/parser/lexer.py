# Python LA library
import ply.lex as lex
import re 

tokens = (
    'LANGLE', # <
)
# HTML Tokens
def t_WHITESPACE(stoken):
    regexr = r' '
    pass

def t_STRING(token):
    regexr = r'"[^"]+"'
    return token

def t_NUMBER(token):
    regexr = r'[0-9]+'
    return token

def t_WORD(token):
    regexr = r'[^ <>]+'
    return token        

# Javascript tokens
def t_commnet(token):
    r'//[^\n]'
def t_numbers(token):
    r'-?[0-9]+(?:\.[0-9]+)?'
