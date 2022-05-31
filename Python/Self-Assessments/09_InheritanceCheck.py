'''
Date: 26-05-2022
Author: Daniel
'''
######################
#### Parent Class ####
######################

# Create FileItem Class
class FileItem:

    # Initialize the permissions, owner and size of the file
    def __init__(self, name, perm, own, size):
        self.filename = name
        self.permissions = perm
        self.owner = own
        self.size = size


#######################
#### Child Classes ####
#######################

# Create CsvFile Class
class CsvFile(FileItem):
    
    # Initialize inheriting from FileItem and additional attributes
    def __init__(self, name, perm, own, size, delim, header):
        FileItem.__init__(self, name, perm, own, size)
        self.delimiter = delim
        self.hasheader = header

# Create JpgFile Class
class JpgFile(FileItem):
    
    # Initialize inheriting from FileItem and additional attributes
    def __init__(self, name, perm, own, size, height, width):
        FileItem.__init__(self, name, perm, own, size)
        self.height = height
        self.width = width

# Create Mp3File Class
class Mp3File(FileItem):
    
    # Initialize inheriting from FileItem and additional attributes
    def __init__(self, name, perm, own, size, length):
        FileItem.__init__(self, name, perm, own, size)
        self.length= length


# Create Directory Class
class Directory(FileItem):

    # Initialize inheriting from FileItem and additional attributes
    def __init__(self, name, perm, own, size):
        FileItem.__init__(self, name, perm, own, size)
        self.files = list()

    # Get files inside the directory
    def addFile(self, file):
        self.files.append(file)

    # List files in Directory
    def listFiles(self):
        filenames = ""
        for file in self.files:
            filenames = filenames + " " + file.filename
        print(filenames)

    # Longlist files in Directory
    def longlistFiles(self):
        for file in self.files:
            print(file.filename, file.permissions, file.owner, file.size)


########################
#### Create Objects ####
########################

# Create a directory in a directory in a directory
dir1 = Directory("dir1", "777", "xllvr", "3.0K")
dir2 = Directory("dir2", "774", "xllvr", "1.2K")
dir3 = Directory("dir3", "700", "xllvr", "600B")

# Nest directories
dir1.addFile(dir2)
dir2.addFile(dir3)

# Create a directory with at least two other directories and at least two files
dir4 = Directory("dir4", "600", "xllvr", "5.0K")
dir1.addFile(dir4)

csv1 = CsvFile("csv1", "644", "xllvr", "300B", ",", "Yes")
jpg1 = JpgFile("jpg1", "600", "xllvr", "1.0M", "300", "1000")
mp31 = Mp3File("mp31", "666", "xllvr", "3.0M", "3:50")
dir1.addFile(csv1)
dir1.addFile(jpg1)
dir1.addFile(mp31)

# Create at least three objects of each type (2 more from each type) and 20 objects in total (currently 7, so 13 more)
# 5 CSV files
csv2 = CsvFile("csv2", "640", "xllvr", "900B", ",", "Yes")
csv3 = CsvFile("csv3", "600", "xllvr", "440B", ",", "Yes")
csv4 = CsvFile("csv4", "655", "xllvr", "31B", ",", "Yes")
csv5 = CsvFile("csv5", "666", "xllvr", "301B", ",", "Yes")
csv6 = CsvFile("csv6", "770", "xllvr", "320B", ",", "Yes")
dir2.addFile(csv2)
dir2.addFile(csv3)
dir2.addFile(csv4)
dir2.addFile(csv5)
dir2.addFile(csv6)

# 4 JPG files
jpg2 = JpgFile("jpg2", "600", "xllvr", "1.0M", "300", "1000")
jpg3 = JpgFile("jpg3", "600", "xllvr", "1.0M", "300", "1000")
jpg4 = JpgFile("jpg4", "600", "xllvr", "1.0M", "300", "1000")
jpg5 = JpgFile("jpg5", "600", "xllvr", "1.0M", "300", "1000")
dir3.addFile(jpg2)
dir3.addFile(jpg3)
dir3.addFile(jpg4)
dir3.addFile(jpg5)

# 4 MP3 files
mp32 = Mp3File("mp32", "666", "xllvr", "3.0M", "3:50")
mp33 = Mp3File("mp33", "666", "xllvr", "3.0M", "3:50")
mp34 = Mp3File("mp34", "666", "xllvr", "3.0M", "3:50")
mp35 = Mp3File("mp35", "666", "xllvr", "3.0M", "3:50")
dir4.addFile(mp32)
dir4.addFile(mp33)
dir4.addFile(mp34)
dir4.addFile(mp35)
