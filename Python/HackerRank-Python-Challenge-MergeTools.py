# *** PYTHON HACKER RANK CHALLENGES ***
# 2. Merge the Tools!

def merge_the_tools(string, k):
    n = len(string)
    t_number = int(n/k)
    s = list(string)
    
    for i in range(0, n, k):
        ti = ''
        for char in s[i:i+k]:
            ti = ti + char
        #print(ti)
        ui = []
        for letter in ti:
            if letter in ui:
                continue
            else: ui.append(letter)
        print(''.join(ui))
    
if __name__ == '__main__':
    string, k = input(), int(input())
    merge_the_tools(string, k)