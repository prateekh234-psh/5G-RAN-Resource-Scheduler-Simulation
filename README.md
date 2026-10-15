# 5G RAN Resource Scheduling and Throughput Optimization

**Status:** Learning project / simulation prototype in progress  
**Tools:** MATLAB (base MATLAB; no 5G Toolbox required for this simplified model)

## Aim
Compare simplified Round Robin, Proportional Fair (PF), and Maximum Throughput (MT) resource-allocation policies across multiple user equipments (UEs).

## Important scope note
This is an educational MAC-scheduler model, **not** a standards-compliant 5G NR simulator. It does not model real radio propagation, channel coding, HARQ, or 3GPP protocol details.

## Run
1. Open `scheduler_demo.m` in MATLAB.
2. Run the script.
3. Review the printed average throughput and fairness values and the bar charts.

## What it demonstrates
- One logical gNB serving multiple UEs
- A simplified resource-block allocation loop
- Comparison of three scheduling policies
- Throughput and Jain's fairness index

## Next improvements
- Repeat trials with different UE counts and random seeds
- Add queue-based latency estimates and resource-utilization plots
- Validate assumptions and document limitations before making conclusions
