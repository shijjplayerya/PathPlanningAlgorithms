%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPAP115
% Project Title: Path Planning using PSO in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function sol1=CreateRandomSolution(model)

    n=model.n;
    
    xmin=model.xmin;
    xmax=model.xmax;
    
    ymin=model.ymin;
    ymax=model.ymax;

    sol1.x=unifrnd(xmin,xmax,1,n);
    sol1.y=unifrnd(ymin,ymax,1,n);
    
end