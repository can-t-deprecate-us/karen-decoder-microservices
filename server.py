from SimpleWebSocketServer import SimpleWebSocketServer, WebSocket
import libh264decoder


class SimpleEcho(WebSocket):

    def handleMessage(self):
        # echo message back to client
        self.sendMessage(self._h264_decode(self.data))

    def handleConnected(self):
        print(self.address, 'connected')

    def handleClose(self):
        print(self.address, 'closed')

    def _h264_decode(self, packet_data):
        self.decoder = libh264decoder.H264Decoder()
        return self.decoder.decode(packet_data)


server = SimpleWebSocketServer('', 8000, SimpleEcho)
server.serveforever()