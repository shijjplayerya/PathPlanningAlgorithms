function Y=compute_angle(X,Xsum,n)%Y��������������x��ĽǶ�����,X��������꣬Xsum��Ŀ����ϰ�����������,��(n+1)*2����
for i=1:n+1%n���ϰ���Ŀ
    deltaX(i)=Xsum(i,1)-X(1);
    deltaY(i)=Xsum(i,2)-X(2);
    r(i)=sqrt(deltaX(i)^2+deltaY(i)^2);
    if deltaX(i)>0
        theta=acos(deltaX(i)/r(i));
    else
        theta=pi-acos(deltaX(i)/r(i));
    end
    if i==1%��ʾ��Ŀ��
        angle=theta;
    else
        angle=theta;
    end
Y(i)=angle;%����ÿ���Ƕ���Y�������棬��һ��Ԫ������Ŀ��ĽǶȣ����涼�����ϰ��ĽǶ�
end
end