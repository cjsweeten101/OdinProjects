var isDown = false;
var color = '#003539';
var rColor = false;
var erase = false;
var colorDefault = '#003539';

$(document).ready(function() {

	var container = $('#container');
	createDivGrid(50, container);

	$('#container').on('dragstart', '.box', function(event) { event.preventDefault(); });
	$('#container').on('mousedown', '.box', startDrawing);
	$('*').mouseup(stopDrawing);
	$('#container').on('mouseover', '.box', function(){
		if(rColor==true){
			draw($(this), randomColor);
		}
		else{
			draw($(this), color);
		}
	});

	$('#clear').click(clear);
	$('#scale').click(function() {
		scaleAlert(container)
	});
	$('#random').click(function() {
		if(rColor == false){
			rColor = true;
			erase = false;
		}
		else {
			rColor = false;
			color = colorDefault;
		}
	})

	$('#eraser').click(function() {
		if(erase == false){
			erase = true;
			rColor = false;
			color = '#ffffff'
		}
		else {
			erase = false;
			color = '#003539'
		}

	})

});

function createDivGrid(numRows, container){
	var dim = calcBoxDim(numRows, container);
	for (var i = 0; i < numRows**2; i++) {
		var newDiv = $('<div class="box"></div>');
		newDiv.css({'width' : dim + 'px', 'height' : dim +'px'});
		container.append(newDiv);
	}
}

function calcBoxDim(numRows, container){
	var width = container.width();
	return width/numRows;
}

function draw(context, color) {
	if(isDown) {
		context.css('background', color);
	}
}

function startDrawing() {
	isDown = true;
}

function stopDrawing() {
	isDown = false;
}

function clear() {
	$('.box').css('background', '#ffffff');
}

function scaleAlert(container) {
	var newDim = prompt('How many squares per side?');
	if(!isNaN(newDim) && newDim != '' && newDim != '1' && newDim != '0'){
		$('.box').remove();
		createDivGrid(newDim, container);
	} else {
		alert('Please enter a valid number')
	}	
}

function randomColor() {
	var letters = '0123456789ABCDEF';
    var newColor = '#';
    for (var i = 0; i < 6; i++ ) {
        newColor += letters[Math.floor(Math.random() * 16)];
    }
    return newColor;
}
