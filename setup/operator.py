#!/usr/bin/env python
# coding: UTF-8
# python2.x

import sys
import os
import json
import logging


OPS_JSON_FILE = 'ops.json'
ENV_FILE = 'mc.env'
LOG_DIR = 'log'
LOG_FILE = LOG_DIR + '/logger.log'


def set_logging():
    """
    ログの設定をします。
    """

    if not os.path.isdir(LOG_DIR):
        os.makedirs(LOG_DIR)
    formatter = '%(levelname)s : %(asctime)s  %(module)s : %(message)s'
    logging.basicConfig(level=logging.DEBUG, filename=LOG_FILE, format=formatter)


def main(args):
    """
    オペレーターをセットするメイン処理です。

    Parameters
    ----------
    args : array
        1:マインクラフトルートパス
        2:docker-composeのenvfileパス
    """

    if len(args) < 3:
        print('ファイルパスを指定してください。')
        sys.exit(1)

    ops_path = args[1] + '/' + OPS_JSON_FILE
    env_path = os.path.join(args[2], ENV_FILE)

    current_ops = []
    if os.path.isfile(ops_path):
        json_contents = decode_json(open(ops_path, 'r'))

        if json_contents is not None:
            current_ops = map(lambda v: v.get('name'), json_contents)
        else:
            return

    new_ops = cmd_operator(current_ops)

    logging.info('cmd_operator end')

    if new_ops:
        logging.info('save file')

        save_env_file(env_path, new_ops)
    else:
        logging.info('Canceled.')
        sys.exit(1)


def decode_json(file_contents):
    """
    operator.jsonをデコードします。

    Parameters
    ----------
    file_contents : file
        デコードするファイルオブジェクト
    """

    try:
        return json.load(file_contents)
    except Exception:
        logging.error('JSON パースエラー')
        return


def cmd_operator(operators):
    """
    オペレーターを編集します。

    Parameters
    ----------
    operators : array
        現在、operator.jsonに設定されているオペレーター

    returns
    -------
    operators : array
        設定するオペレーター

    """

    while True:
        print('登録するオペレーター(管理者)を入力してください。')

        for op in enumerate(operators):
            print(str(op[0] + 1) + '. ' + op[1])

        cmd = raw_input('操作を選択してください。(a:追加, d:削除, y:決定 , c:キャンセル):').strip()

        if cmd == 'a':
            new_op = raw_input('追加するユーザーIDを入力してください。:').strip()

            if new_op:
                if new_op in operators:
                    print('登録済みのユーザーです。')
                else:
                    operators.append(new_op)

        elif cmd == 'd':
            raw_input_no = raw_input('削除するユーザーの番号を入力してください。:').strip()

            if raw_input_no and unicode(raw_input_no).isdecimal():
                del_no = int(raw_input_no)
                if del_no > 0 and del_no <= len(operators):
    	            operators.pop(del_no - 1)
                else:
                    print('番号が範囲外です。')

        elif cmd == 'y':
            if len(operators) == 0:
                print('オペレーターは最低1人登録してください。')
                continue
            else:
                return operators

        elif cmd == 'c':
            return

        else:
            print('コマンドが不正です。')
            continue


def save_env_file(path, operators):
    """
    オペレーター、ホワイトリストをenvfileに書き込みます。

    Parameters
    ----------
    path : string
        envfileパス
    operators : array
        設定対象のオペレーター
    """

    with open(path, 'w') as f:
        f.write('OPS=' + ','.join(operators))
        f.write('\n')
        f.write('WHITELIST=' + ','.join(operators))


if __name__ == '__main__':

    set_logging()

    try:
        main(sys.argv)

    except KeyboardInterrupt:
        logging.info('Interrupt ctrl-c')
        sys.exit(1)

