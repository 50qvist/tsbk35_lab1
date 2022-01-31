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
counts_probs = counts / length(chosen_sound);
%plot(probabilities);

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

huffman_memory_free = huffman(counts_probs)




