for i in $(seq 20);do
  if (( $i % 2 )); then
    echo $i is odd;
    gpio pwm 45 0;
    
  else
    echo $i is even
    gpio pwm 45 100;
  
  fi
  sleep 0.5;
done
