import os

input_dir = r"E:\Old Files\Users\Jared\Desktop\School\5_Year_2_Sem\CSCI 173\Ass 9\json"
output_dir = r"E:\Old Files\Users\Jared\Desktop\School\5_Year_2_Sem\CSCI 173\Ass 9\cleanjson"

for filename in os.listdir(input_dir):
    if filename.endswith('.json'):
        with open(os.path.join(input_dir, filename), 'rb') as f:
            data = f.read()
        clean_data = data.decode('utf-8', 'ignore').encode('utf-8')
        output_filename = os.path.join(output_dir, filename)
        with open(output_filename, 'wb') as f:
            f.write(clean_data)