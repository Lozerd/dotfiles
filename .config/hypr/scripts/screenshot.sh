if [ -z "$XDG_PICTURES_DIR" ]; then
	XDG_PICTURES_DIR="$HOME/Pictures"
fi

save_dir="${2:-$XDG_PICTURES_DIR/Screenshots}"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
save_path="$save_dir/$save_file"
temp_screenshot="/tmp/screenshot.png"

mkdir -p $save_dir

function print_error
{
	cat <<"EOF"
    ./screenshot.sh <action>
    ...valid actions are...
        p  : print all screens
        s  : snip current screen
        sf : snip current screen (frozen)
        m  : print focused monitor
EOF
}

if [ -n "$(pgrep satty)" ]; then
    killall satty
fi


case $1 in
p) # print all outputs
	grimblast --freeze copysave screen $temp_screenshot && satty -f $temp_screenshot -o $save_path ;;
s) # drag to manually snip an area
	grimblast --freeze copysave area $temp_screenshot ;;
sf) # frozen screen, drag to manually snip an area and modify using satty
	grimblast --freeze copysave area $temp_screenshot && satty -f $temp_screenshot -o $save_path ;;
m) # print focused monitor
	grimblast --freeze copysave output $temp_screenshot && satty -f $temp_screenshot -o $save_path ;;
*) # invalid option
	print_error ;;
esac

pngquant $save_path --output $save_path
rm "$temp_screenshot"
