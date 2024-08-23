function minIntMatrix = GenerateMinThicknessMatrix(numTubes,squareTubes)

minIntMatrix = ones(1,numTubes);

% Std Areas (in^2)
RD5x35 = .051129;
RD5x49 = .0694261;
R75x35 = .078618;
R75x49 = .1079106;
RD1x35 = .1524;     %1.3mm
RD1x49 = .1405;  %1.2mm thickness
RD1x65 = .1852;   %1.6mm thickness
RD1x83 = .2272;  %2.0mm thickness
RD1x95 = .2788;  %2.5mm thickness
RD1120 = .331752;
RD1xSD = .785398;
SQ1x35 = .1509;   %equivalent to 25.4mm OD with 1.2mm thickness
SQ1x49 = 0.1806335;
SQ1x65 = 0.2330008;

SquareTubeList = [ ];

tubes95OrMore = [];
    
tubes65OrMoreOr47Square = [1 2 3 4 5 74 75 76 77 78 79 80 83 84 85 86 87 88];

tubes47OrMore = [6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 81 82];

engineTubes = numTubes-14:numTubes;

for i=1:length(tubes95OrMore)
    minIntMatrix(tubes95OrMore(i)) = 12;
end

for i=1:length(tubes65OrMoreOr47Square)
    if squareTubes
        minIntMatrix(tubes65OrMoreOr47Square(i)) = 8;
    else
        minIntMatrix(tubes65OrMoreOr47Square(i)) = 9;
    end
end

for i=1:length(tubes47OrMore)
    minIntMatrix(tubes47OrMore(i)) = 7;
end

for i=1:length(engineTubes)
    minIntMatrix(engineTubes(i)) = 14;
end

% for i=1:numTubes
%     if ~squareTubes
%         for j=1:length(SquareTubeList)
%             if minIntMatrix(i) == SquareTubeList(j)
%                 minIntMatrix(i) = minIntMatrix(i)+1;
%             end
%         end
%     end
% end
%     

end