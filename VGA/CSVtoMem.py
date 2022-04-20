import csv
path = "./"

##with open(path + "colors.csv", "r") as csvFile:
##       with open(path + "colors.mem", "w") as memFile:
##           for row in csv.reader(csvFile):
##              memFile.write(" ".join(row) + "\n")

with open(path + "pause.csv", "r") as csvFile:
    with open(path + "pause.mem", "w") as memFile:
        for row in csv.reader(csvFile):
            memFile.write(" ".join(row) + "\n")
