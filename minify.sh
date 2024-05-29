echo "building"
date -u
python3 ~/Downloads/shrinko8-main\ 2/shrinko8.py tinyhawk.p8 tinyhawk-min.p8 --minify-safe-only
/Applications/PICO-8.app/Contents/MacOS/pico8 -run tinyhawk-min.p8 -export "build/tinyhawk.html -f -p ../plates/better_splash"
/Applications/PICO-8.app/Contents/MacOS/pico8 -run tinyhawk-min.p8 -export "build/tinyhawk.bin -i 231 -s 2 -c 0"
ditto -c -k --sequesterRsrc --keepParent build/tinyhawk_html build/tinyhawk_html.zip
echo "-done-"