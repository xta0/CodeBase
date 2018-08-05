# Python LA library
import ply.lex as lex
import re 


# Javascript tokens
def t_commnet(token):
    r'//[^\n]'
def t_numbers(token):
    r'-?[0-9]+(?:\.[0-9]+)?'
