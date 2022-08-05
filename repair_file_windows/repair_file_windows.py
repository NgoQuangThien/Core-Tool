import os, glob, time
from datetime import datetime


directory = 'C:/BkavEnterprise/ReportPy/BkavReportProcessor_Endpoint/report_to_soc'

auto_remove = True
rotate_time = 1	# 7days


def get_list_file():
	list_file = glob.glob(os.path.join(directory, '*.xml'))
	return list_file

def get_list_new_file(list_file, pre_time, cur_time):
	list_new_file = []
	for x in list_file:
		try:
			ctime_file = os.path.getctime(x)
			if ctime_file >= pre_time and ctime_file <= cur_time:
				list_new_file.append(x)
		except:
				continue
	return list_new_file

def repair_file(path_to_file):
	try:
		with open(path_to_file, mode='a', encoding='UTF-8', newline='\r\n') as f:
			f.write('\n')
	except:
		return False

def remove_old_file(list_file, cur_time):
	for x in list_file:
		try:
			ctime_file = os.path.getctime(x)
			if ctime_file < (cur_time - rotate_time): os.remove(x)
			print(x)
		except:
			continue

def repair_only():
	pre_time = time.time()
	time.sleep(1)

	while True:
		cur_time = time.time()
		list_file = get_list_file()
		list_new_file = get_list_new_file(list_file, pre_time, cur_time)
		for x in list_new_file:	repair_file(x)
		pre_time = cur_time
		time.sleep(3)

def repair_and_remove():
	pre_time = time.time()
	time.sleep(1)

	while True:
		cur_time = time.time()
		list_file = get_list_file()
		list_new_file = get_list_new_file(list_file, pre_time, cur_time)
		for x in list_new_file:	repair_file(x)
		pre_time = cur_time
		remove_old_file(list_file, cur_time)
		time.sleep(3)

if __name__ == '__main__':
	if auto_remove: repair_and_remove()
	else: repair_only()
