# *** PYTHON HACKER RANK CHALLENGES ***
# 1. collections.Counter()

# Enter your code here. Read input from STDIN. Print output to STDOUT
from collections import Counter

X = int(input())
shoes_list = list(input().split())
shoes_list = [int(x) for x in shoes_list]
shoes_counter = Counter(shoes_list)

N = int(input())

total = 0
for i in range(1, N+1):
    buy = list(input().split(' '))
    buy = [int(x) for x in buy]
    buy_subtract = [buy[0]]
    buy_subtract_counter = Counter(buy_subtract)
    shoes_counter.subtract(buy_subtract_counter)
    if shoes_counter[buy[0]] < 0:
        continue
    else:
        total = total + buy[1]
print(total)
