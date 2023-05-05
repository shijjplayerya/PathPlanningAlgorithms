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

map = zeros(10);

% Add an obstacle



map (1:8, 7) = 2;

map(3, 2) = 5; % start_coords

map(4, 9) = 6; % dest_coords

image(1.5,1.5,map);

grid on;

axis image;

%%
% 1.初始化
nrows = 10;

ncols = 10;

start_node = sub2ind(size(map), 3, 2);

dest_node = sub2ind(size(map), 4, 9);

% Initialize distance array
% 1.1 初始化列表1，记录每个点到原点的距离
%     初始化距离都为无穷大
distanceFromStart = Inf(nrows,ncols);

distanceFromStart(start_node) = 0;

% For each grid cell this array holds the index of its parent
% 1.2 初始化列表2，记录每个点的父节点
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
    %     也就是distanceFromStart[]中的最小值
    [min_dist, current] = min(distanceFromStart(:));
    % 如果发现最小值点是终点,结束循环
    if ((current == dest_node) || isinf(min_dist))

        break;

    end;

    % 2.2 更新当前点的四个领点的距离
    % 3代表该点已经被遍历过
    map(current) = 3;
    % 将当前值弹出列表
    distanceFromStart(current) = Inf;
    % 2.2.1 排除掉不在地图的领点
    [i, j] = ind2sub(size(distanceFromStart), current);

    neighbor = [i-1,j;...

    i+1,j;...

    i,j+1;...

    i,j-1];

    outRangetest = (neighbor(:,1)<1) + (neighbor(:,1)>nrows) + (neighbor(:,2)<1) + (neighbor(:,2)>ncols );

    locate = find(outRangetest>0);

    neighbor(locate,:)=[];

    neighborIndex = sub2ind(size(map),neighbor(:,1),neighbor(:,2));

    for i=1:length(neighborIndex)
        % 2.2.2 排除掉障碍物2,已经遍历过的点3,开始点5
        if (map(neighborIndex(i))~=2) && (map(neighborIndex(i))~=3 && map(neighborIndex(i))~= 5)
            % 2.2.3 满足以上两个要求的领点
            %       进入列表,计算距离并填入distanceFromStart中
            map(neighborIndex(i)) = 4;

            if distanceFromStart(neighborIndex(i))> min_dist + 1

                distanceFromStart(neighborIndex(i)) = min_dist+1;

                parent(neighborIndex(i)) = current;
                %pause(1);

            end

        end

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