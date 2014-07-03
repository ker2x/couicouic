<?php

$imageSize=100;

$directory = dirname(__FILE__).'/assets';
$files = array_diff(scandir($directory), array('..', '.'));
foreach ($files as $file) {
	if (strstr($file, '-part-') === false) {
		splitImage($directory.'/'.$file);
	}
}

function splitImage($img) {
	$source = @imagecreatefromjpeg($img);
	$sourceName = pathinfo($img, PATHINFO_FILENAME);
	$width = @imagesx($source);
	$height = @imagesy($source);

	$partsCoords = array(
		array(0, 0, round($width / 2), round($height / 2)),
		array(round($width / 2), 0, $width, round($height / 2)),
		array(0, round($height / 2), round($width / 2), $height),
		array(round($width / 2), round($height / 2), $width, $height)
	);
	$partIdentifier = 0;
	foreach ($partsCoords as $coords) {
		$destTmp = @imagecreatetruecolor(round($width / 2), round($height / 2));
		// imagecopyresized ( resource $dst_image , resource $src_image , int $dst_x , int $dst_y , int $src_x , int $src_y , int $dst_w , int $dst_h , int $src_w , int $src_h )
		@imagecopyresized($destTmp, $source, 0, 0, $coords[0], $coords[1], round($width/2), round($height/2), round($width/2), round($height/2));
		$baseDir = dirname(__FILE__).'/assets';
		$partName = "$baseDir/$sourceName-part-$partIdentifier.jpeg";
		@imagejpeg($destTmp, $partName);
		@imagedestroy($destTmp);
		$partIdentifier++;
	}
}
