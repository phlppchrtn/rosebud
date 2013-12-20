function filter(id) {
	canvas = document.getElementById(id);
	ctx = canvas.getContext('2d');
	width = canvas.width ;
	height =  canvas.height;
	imgData = ctx.getImageData(0, 0, width, height);
	Pixastic.process(img, "pointillize", {radius:15, density:1.5, noise:1.0, transparent:false});
	ctx.putImageData(img, 0, 0);
}

function filter3(id) {
	matrix = [[ -2, 0, 0 ],
               [ 0,  1, 0 ],
               [ 0, 0, 2 ]]; 

	divisor = 1;
	canvas = document.getElementById(id);
	ctx = canvas.getContext('2d');
	width = canvas.width ;
	height =  canvas.height;

	imgData = ctx.getImageData(0, 0, width, height);
	pix = imgData.data;
	var pixTarget=  new Array(pix.length);

	for (i=0; i<pix.length; i++){
		pixTarget[i]= pix[i];
	}

	for (var x=1 ; x<(width - 1) ; x++){
		for (var y=1 ; y< (height-1) ; y++){
			var r = 0;
			var g = 0;
			var b = 0;
			var a = 0;
			for (i=-1 ; i<2 ; i++){
				var coef;	
				for (j=-1 ; j<2 ; j++){
					coef = matrix[i+1][j+1];
					r += rgb (x+i, y+j, pix, width, 0)*coef;
					g += rgb (x+i, y+j, pix, width, 1)*coef;
					b += rgb (x+i, y+j, pix, width, 2)*coef;
					a += rgb (x+i, y+j, pix, width, 3)*coef;
				}
			}
			//setRGB (255 ,pixTarget, x, y, width, 0 );
			//setRGB (0 ,pixTarget, x, y, width, 1 );
			//setRGB (0 ,pixTarget, x, y, width, 2 );
			//setRGB (123 ,pixTarget, x, y, width, 3 );
			setRGB (r /divisor,pixTarget, x, y, width, 0 );
			setRGB (g/divisor ,pixTarget, x, y, width, 1 );
			setRGB (b /divisor,pixTarget, x, y, width, 2 );
			setRGB (a /divisor,pixTarget, x, y, width, 3 );
		}		 
	}		
//	imgData.data = pixTarget;	
	for (i=0; i<pix.length; i++){
		pix[i]= pixTarget[i];
	}
	ctx.putImageData(imgData, 0, 0);
}


function constrain (v,min, max){
 if (v<min) return min;
 if (v>max) return max;
 return v;
}
function setRGB(rgb, pixels, x, y , w, offset){
	pixels[4*(offset+x+y*w)] = constrain(rgb, 0, 255);
 }

function rgb(x, y, pixels, w, offset){
	return pixels[4*(offset+x+y*w)];
 }

