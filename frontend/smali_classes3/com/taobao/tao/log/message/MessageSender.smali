.class public interface abstract Lcom/taobao/tao/log/message/MessageSender;
.super Ljava/lang/Object;
.source "MessageSender.java"


# virtual methods
.method public abstract getSenderInfo()Lcom/taobao/tao/log/message/SenderInfo;
.end method

.method public abstract init(Lcom/taobao/tao/log/message/MessageInfo;)V
.end method

.method public abstract pullMsg(Lcom/taobao/tao/log/message/MessageInfo;)Lcom/taobao/tao/log/message/MessageReponse;
.end method

.method public abstract sendMsg(Lcom/taobao/tao/log/message/MessageInfo;)Lcom/taobao/tao/log/message/MessageReponse;
.end method

.method public abstract sendStartUp(Lcom/taobao/tao/log/message/MessageInfo;)Lcom/taobao/tao/log/message/MessageReponse;
.end method

.method public abstract sendUpdateNick(Lcom/taobao/tao/log/message/MessageInfo;)V
.end method
