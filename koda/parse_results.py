import csv

file = 'results/zfn_random_15_dense'

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

def parse_zfn():
    pass

results = parse_check(keys_zfn)
mat = list(zip(*[results[k] for k in results]))

with open(file + '.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    writer.writerow(results.keys())
    for x in mat:
        # print(x)
        writer.writerow(x)
