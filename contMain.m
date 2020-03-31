function contMain(image)
  [kenar, L] = bwboundaries(image);
  %kenarInt = int32(kenar);
  cntArr = [];
  farkArr = [];
  x1Arr = [];
  y1Arr = [];
  for k = 1:length(kenar)
   sayac = 0;
   ikisayac = 0;
   bolum = 0;
   fark1 = 0;
   fark2 = 0;
   ortF = 0;
   deg = 0;
   boundary = kenar{k};
   sizeB = size(boundary);
   x1Arr = [boundary(1,2)];
   y1Arr = [boundary(1,1)];
   for i = 1:sizeB(1,1)
      y = boundary(i,1);
      x = boundary(i,2);
      asdy = boundary(1,1); %�eklin x ve y koordinatlar� ��kart�l�r
      asdx = boundary(1,2); %arraya eklenir.
      x1Arr = [x1Arr, x];
      y1Arr = [y1Arr, y];
      if i < (sizeB(1,1)-6)
        y1 = boundary(i+6,1); 
        x1 = boundary(i+6,2);
      end
      fark1 = abs(y1-y);  %kernelFonk ard�ndan edgeSmo fonksiyonlar� kullan�ld�ktan 
      fark2 = abs(x1-x);  %sonra olu�an k��e kesitleri ile x ve y koordinatlar� 
      if fark1 > 4 && fark2 > 4 % for d�ng�s� i�erisinde d�nd�r�lerek
        sayac = sayac + 1;  %fark�n 4ten b�y�k olmas� durumunda 
      end                  %bu pixeller aras�nda bir k��e oldu�u tespit edilmi�tir.
      if abs(y1-y) > 3 && abs(x1-x) > 3
        ikisayac = ikisayac + 1;
      end
    end
    if sayac != 0
      bolum = ikisayac / sayac;
    end
      ss = convhull(x1Arr, y1Arr); 
      shArea = polyarea(x1Arr,y1Arr); %kenarlar ve convexhulldan itibaren alanları hesapladım
      cnvArea = polyarea(x1Arr(ss), y1Arr(ss)); %aralarındaki farkın büyük olması yıldız olduğunu belirtir.
      plot(x1Arr(ss), y1Arr(ss), "r-", x1Arr, y1Arr, "b+");     
      axis equal;
      hold on
      fill(x1Arr(ss),y1Arr(ss),'r','facealpha',0.5);
      %disp(asdx); disp(asdy); disp(num2str(k)); disp(num2str(shArea)); disp(num2str(cnvArea)); 
      disp(int32(shArea));
      disp(int32(cnvArea));
      if abs(cnvArea - shArea) > 10000
        if bolum < 2.9
          disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("bes yildiz");
        else
          disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("sekiz yildiz");
      end
      elseif bolum < 2
        if sayac < 100
          disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("dortgen");
        else
          disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("daire");
        end
      elseif bolum >= 2 && bolum < 4
        if sayac < 100
          disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("ucgen");
        else
          disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("besgen");
        end
      elseif bolum >= 4 && bolum < 7.5
        disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("altigen");
      else 
        disp(asdx); disp(asdy); disp(k); disp(bolum); disp(sayac); disp(ikisayac); disp("sekizgen");
      end
      disp("--------");
  end
  %   9/10  --- 7/10
end