var isDown = false;

$(document).ready(function() {

	var container = $('#container');
	createDivGrid(50, container);

	$('#container').on('dragstart', '.box', function(event) { event.preventDefault(); });
	$('#container').on('mousedown', '.box', startDrawing);
	$('*').mouseup(stopDrawing);
	$('#container').on('mouseover', '.box', function(){
		draw($(this), '#003539');
	});

	$('#clear').click(clear);
	$('#scale').click(function() {
		scaleAlert(container)
	});
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
	$('.box').css('background', '#F5F5F6');
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
