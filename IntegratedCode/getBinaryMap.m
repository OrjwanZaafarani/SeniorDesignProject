% Get_Binary_Map
% Binarize the map into a matrix

function BinaryMap = getBinaryMap(jpgFile, s)

    % Read Map jpeg file from workspace
    Map = imread(jpgFile);
    
    % convert each vector in the third dimension to a level of grey
    GrayscaleMap = rgb2gray(Map); 
    
    % Obtain the binary matrix of the map
    BinaryMap0 = imbinarize(GrayscaleMap, s);
    
    % Cleans the Binary Map from unwanted pixels
    size_small_obj = 50; 
    BinaryMap1 = bwareaopen(BinaryMap0,size_small_obj);
    BinaryMap2 = bwareaopen(~BinaryMap1,size_small_obj);
    BinaryMap = ~BinaryMap2;
    
return