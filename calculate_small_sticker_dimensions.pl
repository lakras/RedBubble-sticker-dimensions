# predicts printed dimensions of an image if it is uploaded to RedBubble and printed
# as a 'small' sized sticker, along with the minimum vertical and horizontal
# transparent space that should be between objects to ensure that there is a cut between
# them (that they are printed as separate stickers)

# width and height of the image, not including empty transparent space on the edges
# (to calculate this width and height, open your image in GIMP (or PhotoShop) and crop it
# so that the farthest top, bottom, left, and right points of your picture touch the
# corresponding edges of the image file)
$width_px = $ARGV[0];
$height_px = $ARGV[1];

# printed size of small RedBubble sticker, including padding
$MAX_HEIGHT = 7.2; # from topmost cut to bottommost cut, in cm
$MAX_WIDTH = 9.55; # from leftmost cut to rightmost cut, in cm

# padding added around printed objects, in cm
# vertical or horizontal--diagonal padding can be greater
$PADDING_CM = 0.4;

# formula for converting from width in px to printed width in cm
# with height constant at maximum height
# values found through regression on printed vs. displayed
# sizes (see Excel spreadsheet)
$WIDTH_M = 1.1183; # slope
$WIDTH_B = 0.8351; # intercept

# formula for converting from height in px to printed height in cm
# with width constant at maximum width
$HEIGHT_M = 1.0105;
$HEIGHT_B = 0.2471;

# extra space added to output gap to be EXTRA sure the stickers will be cut separately
$SAFE_GAP_MULTIPLIER = 1.3;


# if width < height, rotate
if($width_px < $height_px)
{
	print "rotated\n";
	$temp = $width_px;
	$width_px = $height_px;
	$height_px = $temp;
}

$height = $MAX_HEIGHT; # cm
$width = ($MAX_HEIGHT * $width_px / $height_px + $WIDTH_B) / $WIDTH_M;

if($width > $MAX_WIDTH)
{
	$width = $MAX_WIDTH;
	$height = ($MAX_WIDTH * $height_px/$width_px + $HEIGHT_B) / $HEIGHT_M;
}

# calculates minimum gap between two items
$min_gap_cm = 2 * $PADDING_CM; # 2 * 4mm padding (vertical or horizontal--diagonal can be more)
$min_gap = ($min_gap_cm * $height_px/$height - 16.462) / 0.8921;

# adds 15 px for safety
$safe_gap = $min_gap * $SAFE_GAP_MULTIPLIER;

# rounds output values
$min_gap = round($min_gap);
$safe_gap = round($safe_gap);
$width = round_to_2_decimal_places($width);
$height = round_to_2_decimal_places($height);

# prints output
print "width:    $width cm\n";
print "height:   $height cm\n";
print "min gap:  $min_gap px\n";
print "safe gap: $safe_gap px\n";
print "(minimum gap of fully transparent space between objects to ensure that they are "
	."cut out as separate stickers in the 'small' sticker size; this gap size is "
	."vertical or horizontal--diagonal padding is larger, so the gap required between "
	."diagonally adjascent objects will also be larger)\n";

sub round
{
	my $num = @_[0];
	my $floor_num = int($num);
	if($num < $floor_num + 0.5)
	{
		return $floor_num;
	}
	return $floor_num + 1;
}

sub round_to_2_decimal_places
{
	my $num = @_[0] * 100;
	return round($num) / 100;
}

# March 9th, 2019