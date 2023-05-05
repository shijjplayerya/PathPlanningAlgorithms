clc;clear all;close all;
%初始化车的参数
tic;
Xo=[1 1];%起点位置
k=15;%计算引力需要的增益系数 15
K=0;%初始化
m=60;%计算斥力的增益系数 6
Po=15;%斥力阈值，当障碍和车的距离大于这个距离时，斥力为0，即不受该障碍的影响 3.5
a=0.5;
l=0.2;%步长
J=200;%循环迭代次数
%如果不能实现预期目标，可能也与初始的增益系数，Po设置的不合适有关。
%end

% 障碍1 目标点附近有障碍
% Xsum=[10 10;4 3;3 3;4 4;5 5;5 7;6 1;8 8;9 9;8 9];
% 障碍2 穿越障碍物
zzz = 7;
Xsum=[10 10;zzz zzz;zzz zzz-1;zzz-1 zzz;zzz-2 zzz;zzz zzz-2];

n = size(Xsum(:,1))-1;%障碍个数
Xj=Xo;%j=1循环初始，将车1的起始坐标赋给Xj
%***************初始化结束，开始主体循环******************
for j=1:J %循环开始
    Goal(j,1)=Xj(1); %Goal是保存车走过的每个点的坐标。刚开始先将起点放进该向量。
    Goal(j,2)=Xj(2);
    %调用计算角度模块
    Theta=compute_angle(Xj,Xsum,n);%Theta是计算出来的车和障碍，和目标之间的与X轴之间的夹角，统一规定角度为逆时针方向，用这个模块可以计算出来。

    %调用计算引力模块
    Angle=Theta(1);%Theta（1）是车和目标之间的角度，目标对车是引力。
    angle_at=Theta(1);%为了后续计算斥力在引力方向的分量赋值给angle_at
    [Fatx,Faty]=compute_Attract(Xj,Xsum,k,Angle,0,Po,n); %计算出目标对车的引力在x,y方向的两个分量值。
    for i=1:n
        angle_re(i)=Theta(i+1);%计算斥力用的角度，是个向量，因为有n个障碍，就有n个角度。
    end

    %调用计算斥力模块
    [Frerxx,Freryy,Fataxx,Fatayy]=compute_repulsion(Xj,Xsum,m,angle_at,angle_re,n,Po,a);%计算出斥力在x,y方向的分量数组。
    %计算合力和方向，这有问题，应该是数，每个j循环的时候合力的大小应该是一个唯一的数，不是数组。应该把斥力的所有分量相加，引力所有分量相加。
    Fsumyj=Faty+Freryy+Fatayy;%y方向的合力
    Fsumxj=Fatx+Frerxx+Fataxx;%x方向的合力
    Position_angle(j)=atan(Fsumyj/Fsumxj);%合力与x轴方向的夹角向量

    %计算车的下一步位置
    Xnext(1)=Xj(1)+l*cos(Position_angle(j));
    Xnext(2)=Xj(2)+l*sin(Position_angle(j));
    %保存车的每一个位置在向量中
    Xj=Xnext;
    %判断
    if ((Xj(1)-Xsum(1,1))>0)&((Xj(2)-Xsum(1,2))>0) %是应该完全相等的时候算作到达，还是只是接近就可以？现在按完全相等的时候编程。
        K=j;%记录迭代到多少次，到达目标。
        break;
        %记录此时的j值
    end%如果不符合if的条件，重新返回循环，继续执行。
end%大循环结束
K=j;
Goal(K,1)=Xsum(1,1);%把路径向量的最后一个点赋值为目标
Goal(K,2)=Xsum(1,2);

%***********************************画出障碍，起点，目标，路径点*************************
%画出路径
X=Goal(:,1);
Y=Goal(:,2);
% %保存mat文件
% A =[X,Y];
% save('lujing.mat','A','-v7.3');
%路径向量Goal是二维数组,X,Y分别是数组的x,y元素的集合，是两个一维数组。


h1=plot(Xo(1),Xo(2),'gO');
hold on
h2=plot(Xsum(1,1),Xsum(1,2),'rO');
hold on

Xsum(1,:) = [];
x = Xsum(:,1);
y = Xsum(:,2);
h3=plot(x,y,'b*');
hold on
h4=plot(X,Y,'r.');
%legend([h1,h2,h3],'起始点','目标点','障碍物');
legend([h1,h2,h3,h4],'起始点','目标点','障碍物','航迹点');
axis([0 12 0 12]);
toc;