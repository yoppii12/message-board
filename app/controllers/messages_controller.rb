class MessagesController < ApplicationController
  def index
    #Messageをすべて取得する。
    @messages=Message.all
    @message=Message.new
  end
  
  ##ここから表記
  def create
    @message=Message.new(message_params)
    if    @message.save
      redirect_to root_path , notice: 'メッセージを保存しました。'
    else
      #メッセージが保存できなかった場合
      @messages=Message.all
      flash.now[:alert]="メッセージの保存に失敗しました。"
      render 'index'
    end
  end
  
  ##ココから下はprivateメソッドとなる
  private
  def message_params
    #params[:message]のパラメータでname, bodyのみ許可する
    #返り値はex:){name:"入力されたname",body:"入力されたbody"}
    params.require(:message).permit(:name, :body)
  end
  ##ここまで
end
