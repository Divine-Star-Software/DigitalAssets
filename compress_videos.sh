rectory containing the videos
VIDEO_DIR="./videos"

# Compression settings
VIDEO_CODEC="libx264"
CRF=28
AUDIO_CODEC="aac"
AUDIO_BITRATE="128k"

# Check if the directory exists
if [ ! -d "$VIDEO_DIR" ]; then
  echo "Directory $VIDEO_DIR does not exist."
  exit 1
fi

# Loop through all video files in the directory
for input_file in "$VIDEO_DIR"/*.{mp4,mkv,avi,flv,mov}; do
  # Check if the file exists (in case no files match the pattern)
  if [ -f "$input_file" ]; then
    # Get the file extension and filename without extension
    file_extension="${input_file##*.}"
    file_basename="$(basename "$input_file" ."$file_extension")"

    # Define the output file name
    output_file="$VIDEO_DIR/${file_basename}_compressed.$file_extension"

    # Compress the video
    ffmpeg -i "$input_file" -vcodec "$VIDEO_CODEC" -crf "$CRF" -acodec "$AUDIO_CODEC" -b:a "$AUDIO_BITRATE" "$output_file"

    echo "Compressed $input_file to $output_file"
  fi
done

echo "All videos have been compressed."
