# Python LA library
import ply.lex as lex
import re 

tokens = (
    'LANGLE', # <
)
# HTML Tokens
def t_RANGLE(token):
    r'>'
    return token
def t_LANGLESLASH(token):
    r'<\/'
    return token

def t_NUMBER(token):
    r'[0-9]+'
    token.value = int(token.value)
    return token;

# math double quote string <a href = "abc" />
def t_STRING(token):
    r'"[^"]+"'
    return token

def t_WHITESPACE(stoken):
    r' '
    pass

def t_WORD(token):
    r'[^ <>]+'
    return token        

# Javascript tokens
def t_commnet(token):
    r'//[^\n]'
def t_numbers(token):
    r'-?[0-9]+(?:\.[0-9]+)?'
