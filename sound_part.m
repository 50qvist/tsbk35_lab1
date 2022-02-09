clear

hey_sound  = 128 * audioread('hey04_8bit.wav');
nuit_sound = 128 * audioread('nuit04_8bit.wav');
speech_sound = 128 * audioread('speech.wav');

%=======Första ordningen entropi H(Xi)=========
chosen_sound = speech_sound;

[temphist,values] = histogram(chosen_sound, -128,127);

counts_probs = temphist / length(chosen_sound);

entropy = -sum(counts_probs.*log2(counts_probs),'omitnan')

%====Parentropi H(Xi, Xi+1)=====

no_pairs = length(chosen_sound)-1;
counts_pairs = zeros(length(values));

for i = 1:no_pairs-1
    counts_pairs(values == chosen_sound(i), values == chosen_sound(i+1)) = counts_pairs(values == chosen_sound(i), values == chosen_sound(i+1)) +1;
end
    %size(counts_pairs)
    %plot(counts_pairs);

count_pairs_prob = counts_pairs/(length(chosen_sound));


entropy_pairs = -sum(count_pairs_prob(:).*log2(count_pairs_prob(:)),'omitnan')
    
%====Betingad entropi H(Xi+1 | Xi)======

% H(Xi+1,Xi) = H(Xi, Xi+1) - H(Xi)

entropy_conditional = entropy_pairs - entropy

% ======================= HUFFMAN PART =====================

%===Memoryless===
huffman_memory_free = huffman(counts_probs)

%===Differences===

%===Predictor 1=== Xi-1
predictor1 = zeros(length(chosen_sound),1);
for i = 2:length(predictor1)
    predictor1(i) = chosen_sound(i-1);
end

differance = chosen_sound - predictor1;

values = (-128:127)';
counts = zeros(length(values),1);

for i=1:length(differance)
    counts(values==differance(i)) = counts(values==differance(i))+1;
end

prob_predictor1 = counts/length(chosen_sound);
rate_predictor1 = huffman(prob_predictor1)

%===Predictor 2=== 2*Xi-1 - Xi-2

predictor2 = zeros(length(chosen_sound),1);

predictor2(2) = 2*chosen_sound(1);
for i = 3:length(predictor2)
    predictor2(i) = 2*chosen_sound(i-1) - chosen_sound(i-2);
end

differance = chosen_sound - predictor2;

values = (-128:127)';
counts = zeros(length(values),1);

for i=1:length(differance)
    counts(values==differance(i)) = counts(values==differance(i))+1;
end

prob_predictor2 = counts/length(chosen_sound);
rate_predictor2 = huffman(prob_predictor2)






















