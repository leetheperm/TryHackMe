state=$(<b64.txt)
for i in {1..15}; do
   state=$(<<<"$state" base64 --decode) 
done
echo "$state";