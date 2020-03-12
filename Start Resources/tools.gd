extends Node

var sTween = preload("res://sTween.tscn")
var sTimer = preload("res://sTimer.tscn")

func pTween(obj,prop,start,end,dur,_trans,_ease,delay,permanent):
	var t = sTween.instance()
	t.interpolate_property(obj,prop,start,end,dur,_trans,_ease,delay)
	if not permanent:
		t.interpolate_callback(t,dur+delay+5,"queue_free")
	t.autostart = true
	return t
	
func tween(obj,prop,start,end,dur,_trans,_ease,delay):
	return pTween(obj,prop,start,end,dur,_trans,_ease,delay,false)

func plTween(obj,prop,start,end,dur,delay,permanent):
	return pTween(obj,prop,start,end,dur,Tween.TRANS_LINEAR, Tween.EASE_IN,delay,permanent)

func lTween(obj,prop,start,end,dur,delay):
	return plTween(obj,prop,start,end,dur,delay,false)

func timer(obj,sec,function,args):
	return pTimer(obj,sec,function,args,false)

func pTimer(obj,sec,function,args,perm):
	var t = sTimer.instance()
	t.set_wait_time(sec)
	t.set_one_shot(true)
	if function:
		t.connect("timeout",obj,function,args,0)
	if not perm:
		t.connect("timeout",t,"queue_free",[],0)
	return t

func counter(sec):
	return timer(self,sec,null,[])

func loop(obj,sec,function,args,limit):
	var t = pTimer(obj,sec,function,args,true)
	if limit:
		add_child(timer(limit*sec,self,"end_loop",[t]))
	t.set_one_shot(false)
	return t
	
func end_loop(timer):
	if timer:
		timer.set_one_shot(false) 
		if timer.get_parent():
			timer.get_parent().remove_child(timer)
	
	
func fadeOut(node,time):
	return tween(node,"modulate",node.self_modulate,Color(0,0,0,0),Tween.TRANS_SINE,Tween.EASE_IN,time,0)
	

func shuffle(arr):
	#print("ARR :",arr,"\n")
	randomize()
	var indecies = []
	
	if arr.size()<2:
		return arr
	
	var newArr = []
	
	for i in range(0,arr.size()):
		indecies.append(i) 
		
	while indecies.size()>1:	
		var numberTaken = randi()%indecies.size()
		var item = arr[indecies[numberTaken]] #get the item at the random index number
		#print("Selected Item: ",item)
		if isRefType(item):
			item = item.duplicate()
		newArr.append(item)
		indecies.remove(numberTaken)
	if indecies.size()==1:
		var lastOne = arr[indecies[0]]
		if isRefType(lastOne):
			lastOne = lastOne.duplicate()
		newArr.append(lastOne)
	#print("Shuffle - NewArr :",newArr,"\n")
	return newArr
		
func isRefType(item):
	return typeof(item)==TYPE_ARRAY or typeof(item)==TYPE_DICTIONARY or typeof(item) == TYPE_OBJECT

func colorForTime(t): #0-95 : 24 hours or 1 unit per 15 minutes
	var c = Color()
	var scale
	if t<24:
		c = Color(.2,.2,.7)
	if t>23 and t<29:
		scale = (t-24)/5.0
		c.r = .2 + .6*scale
		c.g = c.r
		c.b = .7 + .3*scale
	if t>28 and t <48:
		scale = (t-29)/19.0
		c.r = .8 + .2*scale
		c.g = c.r
		c.b = 1
	if t>47 and t<63:
		c = Color(1,1,1,1)	
	if t>62 and t<69:
		scale = (t-63)/6.0
		c.r = 1
		c.g = 1 - .2*scale
		c.b = 1 - .7*scale
	if t>68 and t< 70:
		c.r = 1
	if t>68 and t<80:
		scale = (t-69)/10.0
		c.b = .3 + .4*scale
		c.g = .8 - .2*scale
	if t>79:
		c.b = .7
		c.g = .6- .4*((t-80)/16.0)
	if t>69:
		c.r = 1- .8*((t-70)/22.0)
	return c
	#1-(circ/47)*if time > 47 else 1
