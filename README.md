# RedBubble-sticker-dimensions
The preview that RedBubble provides for small stickers does not accurately represent the sticker size or the padding around objects. This means that objects that are displayed as separate stickers in the preview might not be printed as separate stickers. If you are trying to create a sticker pack with multiple stickers or any other sticker with a specific cut-out shape (https://www.redbubble.com/people/nightlyfieldlog/works/35996711-space-cows-in-space-star-sticker-pack, for example), then RedBubble's preview image can be extremely misleading.

This script predicts the printed dimensions of an image if it is uploaded to RedBubble and printed as a "small" sized sticker, along with the minimum vertical and horizontal transparent space (in pixels) that should be between objects in the image to ensure that there is a cut between them (and that they are printed as separate stickers).

The output includes:
- width (cm) from the leftmost cut to rightmost cut, including the padding added around the image by RedBubble
- height (cm) from the topmost cut to bottommost cut, including the padding added around the image by RedBubble
- estimated minimum gap between objects to ensure they are cut out separately
- a slightly larger gap in case the above estimate is too small


To run, download the script, open your terminal, and enter

`perl [location of script] [non-transparent width (in pixels)] [non-transparent height (in pixels)]`

For example:

`perl /Users/lakras/Downloads/calculate_sticker_dimensions.pl 1325 1309`

The input width and height should not include transparent space on the edges of the image. Open your image in GIMP (or PhotoShop) and crop it so that the farthest top, bottom, left, and right points of your picture touch the corresponding edges of the image file. The resulting width and height are what you should use as input. (RedBubble automatically crops your image to remove any extra transparent space, so you don't need to worry about it when you upload your image to RedBubble.)

This script assumes that the image is large enough to be printed at maximum size in RedBubble's "small" size sticker. To check if that is the case, take a look at the sticker's product page. If the displayed smaller dimension of your small sticker is 3 inches or the displayed larger dimension of your small sticker is 4 inches, then your sticker is probably printed at the maximum small sticker size and this script should work.

Why small stickers? The padding in the large and medium stickers is smaller, relative to the size of the sticker, than the padding in the small stickers. If your small stickers are cut out as separate stickers, then your medium and large stickers definitely will be too.

I have included the measurements of the test stickers I used to estimate constants in the script (and the process of estimating those constants) in test_sticker_dimensions.xlsx.
