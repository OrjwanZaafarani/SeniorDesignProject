function [point1,point2, midpoint] = setCoordinates()

[x,y] = ginput(2);
point1 = [x(1),y(1)];
point2 = [x(2) y(2)];
midpoint = [ceil((x(1)+x(2))/2) , ceil((y(1)+y(2))/2)];

end

