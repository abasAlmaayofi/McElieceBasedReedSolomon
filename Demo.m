    clc
    figure("Name", "Original Image");
    imshow(m)

    [H,G] = cyclgen(255,cyclpoly(255,223));
    P = gf(custRandomPerm(255), 8);
    while 1
         S = gf(round(rand(255)), 8);
         if  det(S).x ~= 0 
             break;
         end
    end

    % Public-Key
     GSP = gf(G*S*P, 8);
    
     % convert image matrix elements to Galois Field elements
    img = gf(m, 8);

    % inverse private keys P, S:
     inv_P = P';
     inv_S = inv(S);
    % inv_SGP = inv_S*SGP*inv_P;

    % generate error matrix
     e = custRandomPerm(255);
     e(255:289, :) = e(1:35, :);
    

    % encode image
     enc = img*GSP + e;
     figure("Name", "Encoded Image");
     imshow(enc.x, [])

    % calculating syndrome
    s = enc*H';
    s(:, 32:255) = 0; 

    % decode image
     dec = enc*inv_P*inv_S + s;
     disp(dec);
     decImage = dec.x;
     decImage(:, 1:32) = [];
     figure("Name","Decoded Image");
     imshow(decImage, []);




     function A = custRandomPerm(n)
      A = eye(n);
      A = A(randperm(n),:);
     end
