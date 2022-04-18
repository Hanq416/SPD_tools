%I = hdrread('90.hdr');
vmsk = vecorf;
%I = I ./vmsk;
%hdrwrite(I,'VC_90.hdr');

%visulize msk
vmsk = 1 - vmsk;
Imsk = (vmsk - min(min(vmsk)))./(max(max(vmsk))- min(min(vmsk))).*256;
%Imsk = (256 - Imsk); 
Imsk = uint8(Imsk); imshow(Imsk);