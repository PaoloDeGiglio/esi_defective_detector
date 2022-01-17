function [pattern,dimPattern] = patternordered(A,R,C)

[M,N] = size(A);

%incidici di partenza dei miei quadratini
x=1;
y=1;

dimPattern=0;
i=1;
incX=ceil((N-R)/(ceil((N/R))/2)); %Lunghezza riga / numero quadratini per ogni riga/2
incY=ceil((M-C)/(ceil((M/C))/2));
while (y+C<N)   %controllo di non uscire dall'ultima riga
    if(x+R<N) %controllo se devo cambiare riga
        pattern{i}.img=A(x:x+R-1, y:y+C-1);
        pattern{i}.basex=x;
        pattern{i}.basey=y;
        pattern{i}.endx=x+R-1;
        pattern{i}.endy=y+C-1;
        pattern{i}.dimx=R;
        pattern{i}.dimy=C;
        x=x+incX; %sposto a dx il quadratino di un valore fisso
    else
        x=1;
        y=y+incY; %abbasso il quadratino di un valore fisso
        if(y+C<M)   %se non esco allora mi salvo il quadratino
            pattern{i}.img=A(x:x+R-1, y:y+C-1);
            pattern{i}.basex=x;
            pattern{i}.basey=y;
            pattern{i}.endx=x+R-1;
            pattern{i}.endy=y+C-1;
            pattern{i}.dimx=R;
            pattern{i}.dimy=C;
        end
    end
    dimPattern=dimPattern+1;
    i=i+1;
end
dimPattern=dimPattern-1; %sistemo contatore

end