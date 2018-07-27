import re 

def t_WHITESPACE(stoken):
    regexr = r' '
    pass

def t_STRING(token):
    regexr = r'"[^"]+"'
    re.findall(regexr,token)
    return token

def t_NUMBER(token):
    regexr = r'[0-9]+'
    re.findall(regexr,token)
    return token

def t_WORD(token):
    regexr = r'[^ <>]+'
    re.findall(regexr,token)
    return token        


