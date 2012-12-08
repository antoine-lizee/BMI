set(gcf,'PaperType','A4');
set(gcf,'PaperOrientation','Landscape');
set(gcf,'PaperUnits', 'Centimeter');
wh = get(gcf,'PaperSize');
margin = 1;
set(gcf,'PaperPosition', [margin margin wh(1)-2*margin wh(2)-2*margin]);

 print -painters -dpdf -r70 'speed.pdf'