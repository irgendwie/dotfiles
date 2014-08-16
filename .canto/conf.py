add("https://gdata.youtube.com/feeds/api/playlists/PL2EC7F45DBD9D9B1A") # My Drunk Kitchen by Hannah Hart
add("https://gdata.youtube.com/feeds/api/playlists/PL2Ufja2qoGV5FNRNR7UR1r6P-Wd8B8RcE") # LeNews by LeFloid
add("https://blog.fefe.de/rss.xml") # Fefes Blog
add("https://xkcd.com/rss.xml") # xkcd
add("http://heise.de.open.feedsportal.com/c/32509/f/480599/index.rss") # heise OpenSource
add("http://heise.de.security.feedsportal.com/c/32407/f/463925/index.rss") # heise Security

link_handler("~/.canto/scripts/ext_link_handler.py \"%u\"") # Youtube handling etc.
link_handler("zathura -f \"%u\"", ext="pdf", fetch=True) # PDF
link_handler("mplayer \"%u\"", ext="mp3") # MP3
image_handler("sxiv -a \"%u\"", fetch=True) # Images
