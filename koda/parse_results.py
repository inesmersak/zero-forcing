import csv

file = 'results/re_zfn_dist_18'

keys_check = ['Graph', 'naive', 'queue_set', 'queue_count']
keys_zfn = ['top_down', 'top_down_subsets', 'binary_search']

def parse_check(keys): 
    results = dict()
    for key in keys:
        results[key] = []


    with open(file + '.txt') as f: 
        for line in f:
            if line.startswith('---'):
                continue
            line = line.strip()
            line = line.rsplit(':', maxsplit=1)
            key = line[0].split()[0]
            val = int(line[1].strip())
            results[key].append(val)

    return results

def parse_re():
    results = []
    N = 100
    i = N
    with open(file + '.txt') as f: 
        temp = []
        for line in f:
            line = line.strip()
            line = line.split('=')
            val = line[1].split(',')[0]
            temp.append(int(val))
            i -= 1
            if i == 0: 
                results.append(temp)
                temp = []
                i = N
    return results

# results = parse_check(keys_zfn)
# mat = list(zip(*[results[k] for k in results]))
mat = parse_re()

with open(file + '.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    # writer.writerow(results.keys())
    writer.writerow([str(x/100.0) for x in range(1,100)])
    for x in mat:
        # print(x)
        writer.writerow(x)
