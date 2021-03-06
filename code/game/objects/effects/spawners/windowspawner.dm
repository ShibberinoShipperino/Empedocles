/obj/effect/spawner/window
	name = "window spawner"
	icon = 'icons/obj/structures2.dmi'
	icon_state = "window_spawner"
	var/useFull = 0
	var/useGrille = 1
	var/windowtospawn = /obj/structure/window
	anchored = 1 // No sliding out while you prime

/obj/effect/spawner/window/initialize()
	spawn(0)
		var/turf/T = get_turf(src)
		for(var/obj/structure/grille/G in get_turf(src))
			// Complain noisily
//			log_runtime(EXCEPTION("Extra grille on turf: ([T.x],[T.y],[T.z])"), src)
			qdel(G) //just in case mappers don't know what they are doing

		if(!useFull)
			for(var/cdir in cardinal)
				for(var/obj/effect/spawner/window/WS in get_step(src,cdir))
					cdir = null
					break
				if(!cdir)	continue
				var/obj/structure/window/WI = new windowtospawn(T)
				WI.dir = cdir
		else
			var/obj/structure/window/W = new windowtospawn(T)
			W.dir = SOUTHWEST

		if(useGrille)
			new /obj/structure/grille(T)

//		src.air_update_turf(1) //atmos can pass otherwise

		spawn(10)
			qdel(src)


/obj/effect/spawner/window/reinforced
	name = "reinforced window spawner"
	icon_state = "rwindow_spawner"
	windowtospawn = /obj/structure/window/reinforced
