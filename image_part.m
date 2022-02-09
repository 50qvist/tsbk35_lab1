baboon = double(imread('baboon.png'));
boat = double(imread('boat.png'));
woodgrain = double(imread('woodgrain.png'));

chosen_image = woodgrain;

%===H(Xi,j)===

[counts,values] = histogram(chosen_image(:), 0, 255);

counts_prob = counts(:)/length(chosen_image(:));

entropy = -sum(counts_prob(:).*log2(counts_prob(:)),'omitnan')

%===H(Xi,j , Xi+1,j)===

img_size = size(chosen_image);

pair_counts = zeros(length(values));

for r = 1:img_size(1)
    for c = 1:img_size(2)-1
        pair_counts(chosen_image(r, c) == values, chosen_image(r, c + 1) == values) = pair_counts(chosen_image(r, c) == values, chosen_image(r, c + 1) == values) +1;
    end
end

prob_pairs = pair_counts/(img_size(1) * (img_size(2)-1));

entropy_pairs_hor = -sum(prob_pairs(:).*log2(prob_pairs(:)),'omitnan')
entropy_pairs_hor_cond = entropy_pairs_hor - entropy

%===H(Xi,j , Xi,j+1)===

pair_counts = zeros(length(values));

for c = 1:img_size(1)
    for r = 1:img_size(2)-1
        pair_counts(chosen_image(r, c) == values, chosen_image(r+1, c) == values) = pair_counts(chosen_image(r, c) == values, chosen_image(r+1, c) == values) +1;
    end
end

prob_pairs = pair_counts/(img_size(1) * (img_size(2)-1));

entropy_pairs_vert = -sum(prob_pairs(:).*log2(prob_pairs(:)),'omitnan')
entropy_pairs_vert_cond = entropy_pairs_vert - entropy

%=======Huffman part=====

huffman_memory_free = huffman(counts_prob)/1

%===Predictor 1===
predictor1 = zeros(img_size);

for r = 1:img_size(1)
    for c = 1:img_size(2)
        if r-1 == 0
            predictor1(r,c) = 128.0;
        else
            predictor1(r,c) = chosen_image(r-1,c);
        end
    end
end

differance = chosen_image-predictor1;

[counts,~] = histogram(differance(:), 0, 255);

counts_prob_pred1 = counts(:)/length(differance(:));

huffman_predictor1 = huffman(counts_prob_pred1)

%===Predictor 2===

predictor2 = zeros(img_size);

for r = 1:img_size(1)
    for c = 1:img_size(2)
        if c-1 == 0
            predictor2(r,c) = 128.0;
        else
            predictor2(r,c) = chosen_image(r,c-1);
        end
    end
end

differance = chosen_image-predictor2;

[counts,~] = histogram(differance(:), 0, 255);

counts_prob_pred2 = counts(:)/length(differance(:));

huffman_predictor2 = huffman(counts_prob_pred2)

%===Predictor 3===

predictor3 = zeros(img_size);

for r = 1:img_size(1)
    for c = 1:img_size(2)
        if c-1 == 0
            cM = 128.0;
        else
            cM = chosen_image(r,c-1);
        end
        
        if r-1 == 0
            rM = 128.0;
        else
            rM = chosen_image(r-1,c);
        end
        
        if r-1 == 0 || c-1 == 0
            rMcM = 128.0;
        else
            rMcM = chosen_image(r-1,c-1);
        end
        
        predictor3(r,c) = rM + cM - rMcM;
        %predictor3(r,c) = chosen_image(r-1,c)+chosen_image(r,c-1)-chosen_image(r-1,c-1);
    end
end

differance = chosen_image-predictor3;

[counts,~] = histogram(differance(:), 0, 255);

counts_prob_pred3 = counts(:)/length(differance(:));

huffman_predictor3 = huffman(counts_prob_pred3)











