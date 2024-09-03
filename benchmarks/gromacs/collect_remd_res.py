import os
import glob


workdir = "./"

log_files = glob.glob(os.path.join(workdir, "state_*", "topol.log"))

ns_per_day_list = []
for log_file in log_files:
    with open(log_file) as f:
        for line in f.readlines()[::-1]:
            if line.startswith("Performance:"):
                ns_per_day = float([e for e in line.strip().split(" ") if e.strip()][1])
                ns_per_day_list.append(ns_per_day)
                break

print(ns_per_day_list)
print(sum(ns_per_day_list) / len(ns_per_day_list))
