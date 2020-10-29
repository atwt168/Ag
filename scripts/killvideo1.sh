kill -s QUIT $1

for i in $(seq 10);do
  if (( $i % 2 )); then
    echo $i is odd;
    gpio pwm 45 0;
    
  else
    echo $i is even
    gpio pwm 45 100;
  
  fi
  sleep 0.5;
done
# sleep 10 
gpio mode 40 output && sleep 1 && gpio write 40 1
