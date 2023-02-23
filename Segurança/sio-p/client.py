import socket
import tkinter as tk

HOST = '127.0.0.1'  # The host IP address
PORT = 65432        # The port used by the server

def show_card(card):
    # Create the main window
    root = tk.Tk()
    root.title("Bingo Card")

    # Create a list to store the labels for each number
    labels = []
    for i in range(5):
        row = []
        for j in range(5):
            label = tk.Label(root, text=card[i][j], bg="white", font=("Helvetica", 24), width=5, height=2)
            label.grid(row=i, column=j)
            row.append(label)
        labels.append(row)

    # Create a function to update the labels
    def update_labels(called_numbers):
        for i in range(5):
            for j in range(5):
                if str(card[i][j]) in called_numbers:
                    labels[i][j].config(bg="yellow")

    # Display the main window
    root.mainloop()

    return update_labels

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    # Connect to the server
    server_socket.connect((HOST, PORT))

    # Receive the bingo card from the server
    card_data = server_socket.recv(1024)
    card_string = card_data.decode().split("Number called:")[0]
    card = eval(card_string.strip())

    # Show the bingo card
    update_labels = show_card(card)

    while True:
        # Receive the called numbers from the server
        data = server_socket.recv(1024).decode()
        called_numbers = data.split("Number called:")[1].split()
        print(data)

        # Update the bingo card
        update_labels(called_numbers)

        # Check if the client has a bingo
        has_bingo = True
        for i in range(5):
            for j in range(5):
                if str(card[i][j]) not in called_numbers:
                    has_bingo = False
                    break
            if not has_bingo:
                break
        if has_bingo:
            server_socket.sendall(b'BINGO')
            print('You have a bingo!')
            break