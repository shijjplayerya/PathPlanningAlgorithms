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

function model=CreateModel()

    % Source
    xs=0;
    ys=0;
    
    % Target (Destination)
    xt=4;
    yt=6;
    
    xobs=[1.5 4.0 1.2 3.5 2.5 1.0];
    yobs=[4.5 3.0 1.5 5.0 3.0 3.0];
    robs=[1.0 1.0 0.8 0.2 0.3 0.5];
    
    n=3;
    
    xmin=-10;
    xmax= 10;
    
    ymin=-10;
    ymax= 10;
    
    model.xs=xs;
    model.ys=ys;
    model.xt=xt;
    model.yt=yt;
    model.xobs=xobs;
    model.yobs=yobs;
    model.robs=robs;
    model.n=n;
    model.xmin=xmin;
    model.xmax=xmax;
    model.ymin=ymin;
    model.ymax=ymax;
    
end