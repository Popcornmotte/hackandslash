extends Node

func playSfx(clip : AudioStream, loop : bool = false):
	for child in $sfx.get_children():
		if child.playing == false:
			child.stream = clip
			child.play()
			if loop:
				return child
			break

func playMusic(music : AudioStream):
	$music/musicPlayer.stream = music
	$music/musicPlayer.play()

func stopMusic():
	$music/musicPlayer.stop()
