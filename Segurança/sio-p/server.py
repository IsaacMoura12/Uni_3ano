import socket
import random
import time

HOST = '127.0.0.1'  # The host IP address
PORT = 65432        # The port used by the server

def generate_bingo_card():
    bingo_numbers = list(range(1, 76))
    random.shuffle(bingo_numbers)
    bingo_card = [[bingo_numbers[5 * i + j] for j in range(5)] for i in range(5)]
    return bingo_card

# Store the called numbers
called_numbers = []

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    # Bind the socket to the host and port
    server_socket.bind((HOST, PORT))

    # Listen for incoming connections
    server_socket.listen()
    print('Server is listening on', HOST, PORT)
    print('Welcome to the Bingo Game!')
    print('Wainting for players...')
    
    # Keep track of the connected clients
    clients = []
    nplayer=input("Enter Number of Players:\n")

    while len(clients) < int(nplayer):
        # Accept a connection from a client
        client_socket, client_address = server_socket.accept()
        print('Accepted connection from', client_address)
        print('Player' , client_address,' Joined The Game')
        clients.append(client_socket)
        
        # Send the bingo card to the client
        bingo_card = generate_bingo_card()
        client_socket.sendall(str(bingo_card).encode())
    print('All players Ready!')
    print('Starting Game...')
    while len(called_numbers) < 76:
        # Call a number
        number = random.choice(list(range(1, 76)))
        while number in called_numbers:
            number = random.choice(list(range(1, 76)))

        called_numbers.append(number)
        
        print('Number called:', number)

        # Send the called number to all clients
        data = 'Number called: ' + str(number)
        for client in clients:
            client.sendall((data + ' ' + ' '.join(str(n) for n in called_numbers)).encode())

        # Wait for 5 seconds
        time.sleep(5)
        