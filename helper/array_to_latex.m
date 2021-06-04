function text = array_to_latex(A)

[m,n] = size(A);

text = '';

for ii = 1:m
    for jj = 1:n
        
        if isnan(A(ii,jj))
            str = '';
        else
            str = num2str(A(ii,jj));
        end
        
        if jj==1
            text = [text,'\bf ',num2str(ii),' ',repelem('&',ii-1)];
        elseif (jj < n) && (jj>ii)
            text = [text,'&',str,' '];
        elseif jj == n 
            text = [text,'&',str,' \\',newline];
        end
    end
end

