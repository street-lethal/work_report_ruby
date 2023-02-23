# Work Report

## 準備

1. 必要ファイル生成
  * ```shell
    cp .env.sample .env
    cp config/settings.sample.yml config/settings.yml
    touch data/report_data.txt
    ```
    もしくは
    ```shell
    ./scripts/0_prepare.sh
    ```
2. Docker 準備 (省略可)
  * ```shell
    docker-compose build
    ```

## 報告用データ出力

1. `config/settings.yml` を編集
  * `months_ago` に対象月が何ヶ月前か入力(当月なら `0` 前月なら `1` )
  * `daily_report` に開始時刻、終了時刻、休憩時間を入力
  * `holidays` に祝日の数字を入力 (土日は入力不要)
2. データ出力
  * ```shell
    docker-compose run --rm ruby ruby scripts_in_docker/output.rb
    ```
    もしくは
    ```shell
    ./scripts/1_output.sh
    ```
3. `data/report_data.txt` にデータが書き込まれていれば成功 (この段階で編集したい部分があれば編集)

## 提出

1. ブラウザーでプラットフォームにログイン
2. 作業報告書の対象月詳細画面へ遷移
3. `.env` を編集
  * `WORK_REPORT_ID` を URL からセット( `/p/workreport/***/` の `***` の部分)
  * `CAKEPHP` を Cookie からセット
  * `AWS_AUTH` を Cookie (キーは `AWSELBAuthSessionCookie-0`) からセット
4. 提出
  * ```shell
    docker-compose run --rm ruby sh ./scripts_in_docker/post_report.sh
    ```
    もしくは
    ```shell
    ./scripts/2_report.sh
    ```
5. ブラウザーの画面をリロードして、データが入力されていれば成功
