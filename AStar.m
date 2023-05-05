close all;

clear all;

clc;

%% % set up color map for display

cmap = [1 1 1; ...% 1 - white - clear cell

0 0 0; ...% 2 - black - obstacle

1 0 0; ...% 3 - red = visited

0 0 1; ...% 4 - blue - on list

0 1 0; ...% 5 - green - start

1 1 0];% 6 - yellow - destination

colormap(cmap);
% 地图大小
side = 10;
map = zeros(side);

% Add an obstacle
% 设置障碍物
map (2:3, 5) = 2;
map (5:9, 5) = 2;
% map(2,3) = 2;
% map(3,5) = 2;

% 设置起始点和目标点
start_r = 3;
start_c = 2;
dest_r = 9;
dest_c = 9;

map(start_r, start_c) = 5; % start_coords

map(dest_r, dest_c) = 6; % dest_coords

% 绘图
image(1.5,1.5,map);

grid on;

axis image;

%%
% 1.初始化
nrows = side;

ncols = side;

start_node = sub2ind(size(map), start_r, start_c);

dest_node = sub2ind(size(map), dest_r, dest_c);

mode = 1;
% Initialize distance array
% 1.1 初始化列表1，记录每个点到原点的距离
%     初始化距离都为无穷大
distanceFromStart = Inf(nrows,ncols);
% 1.2 初始化列表2，记录每个点到目标点的距离
distanceEstimate = Inf(nrows,ncols);

distanceFromStart(start_node) = 0;

distanceEstimate(start_node) = EvaDistance(start_r,start_c,dest_r,dest_c,mode);

% For each grid cell this array holds the index of its parent
% 1.3 初始化列表3，记录每个点的父节点
parent = zeros(nrows,ncols);

% Main Loop
% 2.遍历
while true

    % Draw current map

    map(start_node) = 5;

    map(dest_node) = 6;

    image(map);

    grid on;

    axis image;

    drawnow;

    % Find the node with the minimum distance
    % 2.1 先寻找距离原点最近的节点
    %     也就是distanceEstimate[]中的最小值
    [min_dist, current] = min(distanceEstimate(:));
    % 如果发现最小值点是终点,结束循环
    if ((current == dest_node) || isinf(min_dist))

        break;

    end;

    % 2.2 更新当前点的四个领点的距离
    % 3代表该点已经被遍历过
    map(current) = 3;
    % 将当前值弹出列表
    distanceEstimate(current) = Inf;
    % 2.2.1 排除掉不在地图的领点
    [i, j] = ind2sub(size(distanceEstimate), current);

    neighbor = [i-1,j;...

    i+1,j;...

    i,j+1;...

    i,j-1;...
    
    i+1,j+1;...
    i+1,j-1;...
    i-1,j+1;...
    i-1,j-1];

%     outRangetest = (neighbor(:,1)<1) + (neighbor(:,1)>nrows) + (neighbor(:,2)<1) + (neighbor(:,2)>ncols );
% 
%     locate = find(outRangetest>0);
%     if(locate ~= 0 )
%         neighbor(locate,:)=[0,0];
%     end
    %neighborIndex = sub2ind(size(map),neighbor(:,1),neighbor(:,2));

    for i=1:8
        % 2.2.2 检测是否超出地图
        outRangetest = (neighbor(i,1)<1) + (neighbor(i,1)>nrows) + (neighbor(i,2)<1) + (neighbor(i,2)>ncols );
        if(outRangetest ~=0 )
            continue;
        end

        Index = sub2ind(size(map),neighbor(i,1),neighbor(i,2));
        % 如果在列表内
        if (map(Index)==4 || map(Index)==6)
            % 重新计算G值
            if i>4
                G = distanceFromStart(current)+1.4;
            else
                G = distanceFromStart(current)+1;
            end

            if distanceFromStart(Index)> G

                distanceFromStart(Index) = G;

                parent(Index) = current;

                [row, col] = ind2sub(size(distanceEstimate),Index);
                % 更新评价函数
                %distanceEstimate(Index) = G+abs(row - dest_r)+abs(col - dest_c);
                distanceEstimate(Index) = G+EvaDistance(row,col,dest_r,dest_c,mode);
                %pause(1);

            end

        end
        if(map(Index)==0 || map(Index)==6)
            map(Index)=4;
            % 重新计算G值
            if i>4
                G = distanceFromStart(current)+1.4;
            else
                G = distanceFromStart(current)+1;
            end
            distanceFromStart(Index) = G;
            parent(Index) = current;

            [row, col] = ind2sub(size(distanceEstimate),Index);
            % 更新评价函数
%             distanceEstimate(Index) = G+abs(row - dest_r)+abs(col - dest_c);
            distanceEstimate(Index) = G+EvaDistance(row,col,dest_r,dest_c,mode);

        end
        %pause(0.1);
    end

end

%%

if (isinf(distanceFromStart(dest_node)))

    route = [];

else

    %提取路线坐标

    route = [dest_node];

    while (parent(route(1)) ~= 0)

        route = [parent(route(1)), route];

    end

    % 动态显示出路线

    for k = 2:length(route) - 1

        map(route(k)) = 7;

        pause(0.1);

        image(1.5, 1.5, map);

        grid on;

        axis image;

    end

end

function dis = EvaDistance(x1,y1,x2,y2,mode)
    if mode==1
        % 曼哈顿距离
        dis = abs(x1-x2) + abs(y1 - y2);
    else
        % 欧式距离
        dis = ((x1-x2)^2 + (y1 - y2)^2)^0.5;
    end
end