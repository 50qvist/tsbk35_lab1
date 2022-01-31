clear

hey_sound  = 128 * audioread('hey04_8bit.wav');
nuit_sound = 128 * audioread('nuit04_8bit.wav');
speech_sound = 128 * audioread('speech.wav');

%=======Första ordningen entropi H(Xi)=========
chosen_sound = hey_sound;
values = (-128:127)';
counts = zeros(length(values),1);

for i=1:length(chosen_sound)
    counts(values==chosen_sound(i)) = counts(values==chosen_sound(i))+1;
end

%plot(counts)
count_prob = counts / length(chosen_sound);
%plot(probabilities);

entropy = -sum(count_prob.*log2(count_prob),'omitnan')

%====Parentropi H(Xi, Xi+1)=====

no_pairs = length(chosen_sound)-1;
counts_pairs = zeros(length(values),1);

for i = 1:no_pairs-1
    i
    counts_pairs(values == chosen_sound(i), values == chosen_sound(i+1)) = counts_pairs(values == chosen_sound(i), values == chosen_sound(i+1)) +1;
end
    plot(count_pairs);
%====Betingad entropi H(Xi+1 | Xi)======