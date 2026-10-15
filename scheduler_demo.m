% Simplified educational scheduler comparison.
% This is NOT a standards-compliant 5G NR simulator.
clear; clc; close all;
rng(7);

numUE = 8;
numRB = 50;
numSlots = 500;

% Each entry represents a simplified achievable rate for a UE on an RB.
% Values are synthetic and unitless for demonstrating scheduling logic.
channelRate = 0.5 + 4.5 * rand(numUE, numRB, numSlots);

algorithms = ["Round Robin", "Proportional Fair", "Maximum Throughput"];
totalServed = zeros(numUE, numel(algorithms));

for a = 1:numel(algorithms)
    served = zeros(numUE, 1);
    avgRate = ones(numUE, 1) * 1e-3;
    rrPointer = 1;

    for s = 1:numSlots
        rates = channelRate(:, :, s);
        for rb = 1:numRB
            switch algorithms(a)
                case "Round Robin"
                    ue = rrPointer;
                    rrPointer = rrPointer + 1;
                    if rrPointer > numUE, rrPointer = 1; end
                case "Proportional Fair"
                    score = rates(:, rb) ./ avgRate;
                    [~, ue] = max(score);
                otherwise % Maximum Throughput
                    [~, ue] = max(rates(:, rb));
            end
            amount = rates(ue, rb);
            served(ue) = served(ue) + amount;
            avgRate(ue) = 0.95 * avgRate(ue) + 0.05 * amount;
        end
    end

    totalServed(:, a) = served;
end

sumThroughput = sum(totalServed, 1);
fairness = zeros(1, numel(algorithms));
for a = 1:numel(algorithms)
    x = totalServed(:, a);
    fairness(a) = (sum(x)^2) / (numUE * sum(x.^2));
end

fprintf('Simplified model: %d UEs, %d RBs/slot, %d slots\n', numUE, numRB, numSlots);
for a = 1:numel(algorithms)
    fprintf('%-22s total served = %10.2f | Jain fairness = %.3f\n', ...
        algorithms(a), sumThroughput(a), fairness(a));
end

figure;
bar(sumThroughput);
set(gca, 'XTickLabel', algorithms);
ylabel('Total served rate (synthetic units)');
title('Scheduler Throughput Comparison');
grid on;

figure;
bar(fairness);
set(gca, 'XTickLabel', algorithms);
ylabel('Jain fairness index (0 to 1)');
title('Scheduler Fairness Comparison');
ylim([0 1]);
grid on;
