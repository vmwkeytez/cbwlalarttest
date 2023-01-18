@echo off
chcp 65001

rem 65001 = UTF-8
rem 932 = Shift-JIS

rem 別プロセスでGETリクエストを定期送信する
rem 接続先テキストファイルに合わせて次のコマンドを編集
start powershell -WindowStyle Hidden -command "$connectto = Get-Content .\connect.txt; while (1) {curl $connectto ; Start-Sleep -s 4}"

rem eicarの公式サイトから圧縮ファイルでダウンロードして保存・解凍する
bitsadmin /transfer download https://github.com/vmwkeytez/cbwlalarttest/raw/main/eicar_com.zip %CD%\eicar.zip
rem bitsadmin /transfer download https://secure.eicar.org/eicar.com %CD%\eicar.com
powershell -command "Expand-Archive -Path .\eicar.zip -DestinationPath ."
start %CD%\eicar.com

rem ダミーのtxtファイルを作成してメモ帳で開く
echo ご確認ください！ > .\dummy.txt
echo 「ここに読むのに時間のかかる釣りメッセージ」 >> .\dummy.txt
start /wait notepad.exe .\dummy.txt
del dummy.txt