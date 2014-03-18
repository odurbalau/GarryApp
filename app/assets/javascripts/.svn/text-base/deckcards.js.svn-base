var flip = function(content, bindfunction, target, direction, color){
    	$(target).flippy({
			color_target:color,
			content:$(content),
			direction:direction,
			duration:"200",
			light:"40",
			onFinish:function(){
				$(target).unbind('click');
				$(target).bind("click",bindfunction);
			}
		});
};

var fadeoutcard = function(targetcard){
	$(targetcard).fadeOut(200);
};

var fadeincard = function(targetcard){
	$(targetcard).delay(200).fadeIn(200);
};