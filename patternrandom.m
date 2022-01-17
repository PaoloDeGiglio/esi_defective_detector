function [pattern,dimPattern] = patternrandom(A,R,C,number)

[M,N] = size(A);

%incidici di partenza dei miei quadratini
x=1;
y=1;

dimPattern=0;
i=1;
while (i<number) 
    randX = randi(M-R,1)+1;
    randY = randi(N-C,1)+1;
    fprintf("x %d",randX);
    fprintf("y %d",randY);
    x = randX;
    y = randY;
    pattern{i}.img=A(x:x+R-1, y:y+C-1);
    pattern{i}.basex=x;
    pattern{i}.basey=y;
    pattern{i}.endx=x+R-1;
    pattern{i}.endy=y+C-1;
    pattern{i}.dimx=R;
    pattern{i}.dimy=C;
    dimPattern=dimPattern+1;
    i=i+1;
end
dimPattern=dimPattern-1; %sistemo contatore

end