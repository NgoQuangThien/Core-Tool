import os, glob, time
from datetime import datetime


directory = 'I:/test'

def repair_file(file_path):
	with open(file_path, mode='a', encoding='UTF-8', newline='\r\n') as f:
		f.write('\n')

if __name__ == '__main__':
	list_file = glob.glob(os.path.join(directory, '*.xml'))
	for file_path in list_file:
		print("Phat hien file: "+ file_path)
		f = ''.join(file_path)
		repair_file(f)
