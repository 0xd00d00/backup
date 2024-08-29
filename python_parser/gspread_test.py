import gspread

gc = gspread.service_account()
sh = gc.open("꿈이룬하루테스트")


worksheet = sh.get_worksheet(1)

#self.worksheet.update(range_name=new_date_dir, values=[[date]])
#worksheet.update('[C3, C7, C8]','[["O"], ["O"], ["O"]]') 

tmp = 'E' + str(1) +':E' + str(4)
tmp2 = 'E'
tmp1 = f"{tmp2}1:{tmp2}24"
print(tmp, tmp1)

cell_values = [4,5,6,1,2]

cell_list = worksheet.range(tmp1)
for i,val in enumerate(cell_values):
    print(i, val, type(i), type(val))
    cell_list[val].value = "O"

worksheet.update_cells(cell_list)

#  
#  data = [
#      ['23년 1월 10일 (화)', '철수', 'ok'],
#      ['', '영희', 'ok'],
#      ['', '수철', 'ok']
#  ]
#  
#  worksheet = sh.get_worksheet(1)
#  
#  target_row_number = 2 # B
#  
#  row_data = worksheet.row_values(target_row_number)
#  
#  print(row_data, len(row_data))
#  
#  range_notation = f"{chr(len(row_data) + 1 + 64)}4"
#  
#  print(range_notation)
#  worksheet.update(values= ["o",""], range_name = range_notation)
