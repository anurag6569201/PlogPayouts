echo "BUILD START"
pip install -r requirements.txt
python 3.10 manage.py collectstatic --noinput --clear
echo "BUILD END"