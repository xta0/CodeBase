import json
from jsoncomparison import Compare
import sys


    
def main():
    f1 = sys.argv[1]
    f2 = sys.argv[2]
    with open(f1, 'r') as f:
        t1 = f.read()
        json1 = json.loads(t1)
    
    with open(f2, 'r') as f:
        t2 = f.read()
        json2 = json.loads(t2)
         
    diff = Compare().check(json1, json2)
    print(type(diff))
    # print(diff_json)
    with open('./json_diff.json', 'w') as f:
        f.write(json.dumps(diff))
    
if __name__ == "__main__":
    main()
