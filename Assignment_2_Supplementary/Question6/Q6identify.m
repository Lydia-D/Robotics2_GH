    CC = bwconncomp(E);
    numPixels = cellfun(@numel,CC.PixelIdxList);
    % only over 100 pixels
    idx = find(numPixels>10);
    for i = 1:1:length(idx)
        E(CC.PixelIdxList{idx(i)}) % remove
    end
    figure,imshow(E)
    
%     [biggest,idx] = max(numPixels);
%     BW(CC.PixelIdxList{idx}) = 0;