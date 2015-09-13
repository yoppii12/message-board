#フォームで入力されたパラメータを受け取りデータベースへ保存する
class MessagesController < ApplicationController
  #set_messageアクションを任意の処理（ここではedit,update）の前に実行できる
  before_action :set_message, only: [:edit, :update, :destroy]
  
  def index
    #Messageをすべて取得する。
    @messages=Message.all
    @message=Message.new
  end
  
  #editアクション自体は空だが、実行時にset_message,edit.html.erbをレンダリング
  def edit
  end
  
  #削除アクション
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end
  
  #アップデートアクション
  def update
    if @message.update(message_params)
      #保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました。'
    else
      #保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  ##ここから表記（フォームで入力された内容を保存するためのインスタンスを作成）
  #その後、.saveでメッセージモデルのインスタンスをDBに保存する
  def create
    @message=Message.new(message_params)
    if    @message.save
      #ルートURLにリダイレクトする
      redirect_to root_path , notice: 'メッセージを保存しました。'
    else
      #メッセージが保存できなかった場合（Message.saveでfalseが返ってくる）は
      #入力画面に戻し（render 'index'）、再度入力を促す
      @messages=Message.all
      flash.now[:alert]="メッセージの保存に失敗しました。"
      render 'index'
    end
  end
  
  ##ココから下はprivateメソッドとなる
  private
  def message_params
    #params[:message]のパラメータでname, body,ageのみ許可する
    #返り値はex:){name:"入力されたname",age:"入力されたage",body:"入力されたbody"}
    params.require(:message).permit(:name, :age, :body)
  end
  ##ここまで
  
  def set_message
    @message=Message.find(params[:id])
  end
  
end
