curl "https://platform.levtech.jp/p/workreport/input/$WORK_REPORT_ID/" \
-b "CAKEPHP=$CAKEPHP" \
-b "AWSELBAuthSessionCookie-0=$AWS_AUTH" \
-b "login=p" \
-H "content-type: application/x-www-form-urlencoded" \
-H "Referer: https://platform.levtech.jp/p/workreport/input/$WORK_REPORT_ID/" \
-X POST \
-i \
-d @/app_root/data/report_data.txt
