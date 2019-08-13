import csv

file = 'results/results_path'

results = dict()
for key in ['Graph', 'naive', 'queue_set', 'queue_count']:
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

mat = list(zip(*[results[k] for k in results]))

with open(file + '.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    writer.writerow(results.keys())
    for x in mat:
        # print(x)
        writer.writerow(x)
