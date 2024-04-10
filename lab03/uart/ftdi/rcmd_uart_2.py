# Enable pyserial extensions
import pyftdi.serialext

# Open a serial port on the second FTDI device interface (IF/2) @ 3Mbaud
brate = 230400
#115200
#9600
#230400
#shockley
#url  = 'ftdi://ftdi:232:AQ00RVQC/1'
#UBUNTU at home
url = 'ftdi://ftdi:232:AQ00JS2S/1'
port = pyftdi.serialext.serial_for_url(url, baudrate=brate, bytesize=8, stopbits=1, parity='N', xonxoff=False, rtscts=False)

b = bytes([0x35, 0xd1])
port.write(b)

# Receive bytes
nb = 17
print("Receiving at", brate)
print("Number of bytes:", nb)
#for i in range(1,6):
data = port.read(nb)
print('-', data)
#
