extends StaticBody3D

func hit(dmg):
	get_parent().hit(dmg)
	#get_parent().health -= dmg
