mkv-disable-default() {
    local file="$1"
    shift

    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        return 1
    fi

    for track in "$@"; do
        echo "Disabling default flag on track $track in $file"
        mkvpropedit "$file" --edit track:$track --set flag-default=0
    done
}

mkv-enable-default() {
    local file="$1"
    shift

    if [ ! -f "$file" ]; then
        echo "File not found: $file"
        return 1
    fi

    for track in "$@"; do
        echo "Enabling default flag on track $track in $file"
        mkvpropedit "$file" --edit track:$track --set flag-default=1
    done
}

mkv-list-default() {
  mkvmerge --identify-verbose "$1"
}

mkv-rename() {
    mkvpropedit "$1" --edit info --set "title=$2"
}

# Youtube Download Playlist
alias dlp='yt-dlp -f bestaudio --extract-audio --audio-format m4a --audio-quality 0 --embed-thumbnail --add-metadata -o "%(playlist_index)03d - %(title)s.%(ext)s" --download-archive ~/dlp_downloaded.txt'
