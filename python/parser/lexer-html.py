# Python LA library
import ply.lex as lex
import re 

tokens = (
    'LANGLE', # <
    'LANGLESLASH' #</
    'RANGLE', #>
    'EQUAL', #=
    'STRING', #"hello"
    'WORD' #welcome!
)
t_ignore = ' ' #shortcut for whitespaces

# HTML Tokens
def t_LANGLESLASH(token):
    r'<\/'
    return token

def t_LANGLE(token):
    r'<'
    return token


def t_RANGLE(token):
    r'>'
    return token

def t_EQUAL(token):
    r'='
    return token

# math double quote string <a href = "abc" />
def t_STRING(token):
    r'"[^"]+"'
    token.value = token.value[1:-1] #remove ""
    return token

# def t_WHITESPACE(token):
#     r' '
#     pass

def t_WORD(token):
    r'[^ <>]+'
    return token     

def t_NUMBER(token):
    r'[0-9]+'
    token.value = int(token.value)
    return token

webpage = 'This is <b>my</b> webpage!'
htmllexer = lex.lex()
htmllexer.input(webpage)
while True:
        tok = htmllexer.token() #return next token
        if not tok: 
            break
        print(tok)



