echo "load test"

for ((i=0; i<100; i++)); do
    curl -s -o /dev/null http://localhost:8080/
done
