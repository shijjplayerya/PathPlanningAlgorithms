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

function PlotSolution(sol,model)

    xs=model.xs;
    ys=model.ys;
    xt=model.xt;
    yt=model.yt;
    xobs=model.xobs;
    yobs=model.yobs;
    robs=model.robs;
    
    XS=sol.XS;
    YS=sol.YS;
    xx=sol.xx;
    yy=sol.yy;
    
    theta=linspace(0,2*pi,100);
    for k=1:numel(xobs)
        fill(xobs(k)+robs(k)*cos(theta),yobs(k)+robs(k)*sin(theta),[0.5 0.7 0.8]);
        hold on;
    end
    plot(xx,yy,'k','LineWidth',2);
    plot(XS,YS,'ro');
    plot(xs,ys,'bs','MarkerSize',12,'MarkerFaceColor','y');
    plot(xt,yt,'kp','MarkerSize',16,'MarkerFaceColor','g');
    hold off;
    grid on;
    axis equal;

end