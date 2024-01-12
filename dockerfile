FROM alpine  

RUN echo "Hello, World!" > /hello.txt  # Create a text file with the message

CMD cat /hello.txt