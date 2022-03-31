# Transmit Files 
One half of the project that is aimed towards transmiting data from a computer to the system (and LED lights).

## Documentation

### Header bits
After the preamble bits, 3 bits are reserved to store information on the type of data that the rest of the bits are storing.<br>
| Header | defination                    |
|--------|-------------------------------|
|  000   | plain text                    |
|  001   | encrypted text                |
|  010   | CMD: store plain text         |
|  010   | CMD: store encrypted text     |
|  100   | CMD: load plain text file     |
|  001   | CMD: load encrypted text file |
|  110   | Direct command                |
|  111   | Run command from stored file  |
|        |                               |


