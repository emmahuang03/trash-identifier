from flask import Flask, render_template
from flask_socketio import SocketIO, emit

app = Flask(__name__)
socketio = SocketIO(app)

# Event handler for a connection event
@socketio.on('connect')
def handle_connect():
    print('Client connected')

# Event handler for a custom event
@socketio.on('custom_event')
def handle_custom_event(data):
    print('Received data:', data)

    # Emit a response event
    response_data = {'message': 'This is the response from the server'}
    emit('response_event', response_data)

if __name__ == '__main__':
    socketio.run(app)
